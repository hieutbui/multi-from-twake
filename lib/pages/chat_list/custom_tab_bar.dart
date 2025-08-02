import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const double _kTabHeight = 46.0;
const double _kTextAndIconTabHeight = 72.0;
const double _kStartOffset = 52.0;

class _TabStyle extends AnimatedWidget {
  const _TabStyle({
    required Animation<double> animation,
    required this.isSelected,
    required this.isPrimary,
    required this.labelColor,
    required this.unselectedLabelColor,
    required this.labelStyle,
    required this.unselectedLabelStyle,
    required this.defaults,
    required this.child,
  }) : super(listenable: animation);

  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final bool isSelected;
  final bool isPrimary;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final TabBarTheme defaults;
  final Widget child;

  MaterialStateColor _resolveWithLabelColor(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TabBarTheme tabBarTheme = TabBarTheme.of(context);
    final Animation<double> animation = listenable as Animation<double>;
    Color selectedColor = labelColor ??
        tabBarTheme.labelColor ??
        labelStyle?.color ??
        tabBarTheme.labelStyle?.color ??
        defaults.labelColor!;

    final Color unselectedColor;

    if (selectedColor is MaterialStateColor) {
      unselectedColor = selectedColor.resolve(const <MaterialState>{});
      selectedColor =
          selectedColor.resolve(const <MaterialState>{MaterialState.selected});
    } else {
      unselectedColor = unselectedLabelColor ??
          tabBarTheme.unselectedLabelColor ??
          unselectedLabelStyle?.color ??
          tabBarTheme.unselectedLabelStyle?.color ??
          (themeData.useMaterial3
              ? defaults.unselectedLabelColor!
              : selectedColor.withAlpha(0xB2)); // 70% alpha
    }

    return MaterialStateColor.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Color.lerp(selectedColor, unselectedColor, animation.value)!;
      }
      return Color.lerp(unselectedColor, selectedColor, animation.value)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TabBarTheme tabBarTheme = TabBarTheme.of(context);
    final Animation<double> animation = listenable as Animation<double>;

    final Set<MaterialState> states = isSelected
        ? const <MaterialState>{MaterialState.selected}
        : const <MaterialState>{};

    final TextStyle selectedStyle =
        (labelStyle ?? tabBarTheme.labelStyle ?? defaults.labelStyle!)
            .copyWith(inherit: true);
    final TextStyle unselectedStyle = (unselectedLabelStyle ??
            tabBarTheme.unselectedLabelStyle ??
            labelStyle ??
            defaults.unselectedLabelStyle!)
        .copyWith(inherit: true);
    final TextStyle textStyle = isSelected
        ? TextStyle.lerp(selectedStyle, unselectedStyle, animation.value)!
        : TextStyle.lerp(unselectedStyle, selectedStyle, animation.value)!;
    final Color color = _resolveWithLabelColor(context).resolve(states);

    return DefaultTextStyle(
      style: textStyle.copyWith(color: color),
      child: IconTheme.merge(
        data: IconThemeData(
          size: 24.0,
          color: color,
        ),
        child: child,
      ),
    );
  }
}

typedef _LayoutCallback = void Function(
    List<double> xOffsets, TextDirection textDirection, double width);

class _TabLabelBarRenderer extends RenderFlex {
  _TabLabelBarRenderer({
    required super.direction,
    required super.mainAxisSize,
    required super.mainAxisAlignment,
    required super.crossAxisAlignment,
    required TextDirection super.textDirection,
    required super.verticalDirection,
    required this.onPerformLayout,
  });

  _LayoutCallback onPerformLayout;

  @override
  void performLayout() {
    super.performLayout();
    RenderBox? child = firstChild;
    final List<double> xOffsets = <double>[];
    while (child != null) {
      final FlexParentData childParentData =
          child.parentData! as FlexParentData;
      xOffsets.add(childParentData.offset.dx);
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }
    assert(textDirection != null);
    switch (textDirection!) {
      case TextDirection.rtl:
        xOffsets.insert(0, size.width);
      case TextDirection.ltr:
        xOffsets.add(size.width);
    }
    onPerformLayout(xOffsets, textDirection!, size.width);
  }
}

class _TabLabelBar extends Flex {
  const _TabLabelBar({
    super.children,
    required this.onPerformLayout,
    required super.mainAxisSize,
  }) : super(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
        );

  final _LayoutCallback onPerformLayout;

  @override
  RenderFlex createRenderObject(BuildContext context) {
    return _TabLabelBarRenderer(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context)!,
      verticalDirection: verticalDirection,
      onPerformLayout: onPerformLayout,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _TabLabelBarRenderer renderObject) {
    super.updateRenderObject(context, renderObject);
    renderObject.onPerformLayout = onPerformLayout;
  }
}

double _indexChangeProgress(TabController controller) {
  final double controllerValue = controller.animation!.value;
  final double previousIndex = controller.previousIndex.toDouble();
  final double currentIndex = controller.index.toDouble();

  if (!controller.indexIsChanging) {
    return clampDouble((currentIndex - controllerValue).abs(), 0.0, 1.0);
  }

  return (controllerValue - currentIndex).abs() /
      (currentIndex - previousIndex).abs();
}

class _DividerPainter extends CustomPainter {
  _DividerPainter({
    required this.dividerColor,
    required this.dividerHeight,
  });

  final Color dividerColor;
  final double dividerHeight;

  @override
  void paint(Canvas canvas, Size size) {
    if (dividerHeight <= 0.0) {
      return;
    }

    final Paint paint = Paint()
      ..color = dividerColor
      ..strokeWidth = dividerHeight;

    canvas.drawLine(
      Offset(0, size.height - (paint.strokeWidth / 2)),
      Offset(size.width, size.height - (paint.strokeWidth / 2)),
      paint,
    );
  }

  @override
  bool shouldRepaint(_DividerPainter oldDelegate) {
    return oldDelegate.dividerColor != dividerColor ||
        oldDelegate.dividerHeight != dividerHeight;
  }
}

class _IndicatorPainter extends CustomPainter {
  _IndicatorPainter({
    required this.controller,
    required this.indicator,
    required this.indicatorSize,
    required this.tabKeys,
    required _IndicatorPainter? old,
    required this.indicatorPadding,
    required this.labelPaddings,
    this.dividerColor,
    this.dividerHeight,
    required this.showDivider,
    this.devicePixelRatio,
  }) : super(repaint: controller.animation) {
    if (kFlutterMemoryAllocationsEnabled) {
      FlutterMemoryAllocations.instance.dispatchObjectCreated(
        library: 'package:flutter/material.dart',
        className: '$_IndicatorPainter',
        object: this,
      );
    }
    if (old != null) {
      saveTabOffsets(old._currentTabOffsets, old._currentTextDirection);
    }
  }

  final TabController controller;
  final Decoration indicator;
  final TabBarIndicatorSize indicatorSize;
  final EdgeInsetsGeometry indicatorPadding;
  final List<GlobalKey> tabKeys;
  final List<EdgeInsetsGeometry> labelPaddings;
  final Color? dividerColor;
  final double? dividerHeight;
  final bool showDivider;
  final double? devicePixelRatio;

  List<double>? _currentTabOffsets;
  TextDirection? _currentTextDirection;

  Rect? _currentRect;
  BoxPainter? _painter;
  bool _needsPaint = false;
  void markNeedsPaint() {
    _needsPaint = true;
  }

  void dispose() {
    if (kFlutterMemoryAllocationsEnabled) {
      FlutterMemoryAllocations.instance.dispatchObjectDisposed(object: this);
    }
    _painter?.dispose();
  }

  void saveTabOffsets(List<double>? tabOffsets, TextDirection? textDirection) {
    _currentTabOffsets = tabOffsets;
    _currentTextDirection = textDirection;
  }

  int get maxTabIndex => _currentTabOffsets!.length - 2;

  double centerOf(int tabIndex) {
    assert(_currentTabOffsets != null);
    assert(_currentTabOffsets!.isNotEmpty);
    assert(tabIndex >= 0);
    assert(tabIndex <= maxTabIndex);
    return (_currentTabOffsets![tabIndex] + _currentTabOffsets![tabIndex + 1]) /
        2.0;
  }

  Rect indicatorRect(Size tabBarSize, int tabIndex) {
    assert(_currentTabOffsets != null);
    assert(_currentTextDirection != null);
    assert(_currentTabOffsets!.isNotEmpty);
    assert(tabIndex >= 0);
    assert(tabIndex <= maxTabIndex);
    double tabLeft, tabRight;
    (tabLeft, tabRight) = switch (_currentTextDirection!) {
      TextDirection.rtl => (
          _currentTabOffsets![tabIndex + 1],
          _currentTabOffsets![tabIndex]
        ),
      TextDirection.ltr => (
          _currentTabOffsets![tabIndex],
          _currentTabOffsets![tabIndex + 1]
        ),
    };

    if (indicatorSize == TabBarIndicatorSize.label) {
      final double tabWidth = tabKeys[tabIndex].currentContext!.size!.width;
      final EdgeInsetsGeometry labelPadding = labelPaddings[tabIndex];
      final EdgeInsets insets = labelPadding.resolve(_currentTextDirection);
      final double delta =
          ((tabRight - tabLeft) - (tabWidth + insets.horizontal)) / 2.0;
      tabLeft += delta + insets.left;
      tabRight = tabLeft + tabWidth;
    }

    final EdgeInsets insets = indicatorPadding.resolve(_currentTextDirection);
    final Rect rect =
        Rect.fromLTWH(tabLeft, 0.0, tabRight - tabLeft, tabBarSize.height);

    if (!(rect.size >= insets.collapsedSize)) {
      throw FlutterError(
        'indicatorPadding insets should be less than Tab Size\n'
        'Rect Size : ${rect.size}, Insets: $insets',
      );
    }
    return insets.deflateRect(rect);
  }

  @override
  void paint(Canvas canvas, Size size) {
    _needsPaint = false;
    _painter ??= indicator.createBoxPainter(markNeedsPaint);

    final double index = controller.index.toDouble();
    final double value = controller.animation!.value;
    final bool ltr = index > value;
    final int from = (ltr ? value.floor() : value.ceil()).clamp(0, maxTabIndex);
    final int to = (ltr ? from + 1 : from - 1).clamp(0, maxTabIndex);
    final Rect fromRect = indicatorRect(size, from);
    final Rect toRect = indicatorRect(size, to);
    _currentRect = Rect.lerp(fromRect, toRect, (value - from).abs());

    _currentRect = switch (indicatorSize) {
      TabBarIndicatorSize.label => _applyStretchEffect(_currentRect!),
      TabBarIndicatorSize.tab => _currentRect,
    };

    assert(_currentRect != null);

    final ImageConfiguration configuration = ImageConfiguration(
      size: _currentRect!.size,
      textDirection: _currentTextDirection,
      devicePixelRatio: devicePixelRatio,
    );
    if (showDivider && dividerHeight! > 0) {
      final Paint dividerPaint = Paint()
        ..color = dividerColor!
        ..strokeWidth = dividerHeight!;
      final Offset dividerP1 =
          Offset(0, size.height - (dividerPaint.strokeWidth / 2));
      final Offset dividerP2 =
          Offset(size.width, size.height - (dividerPaint.strokeWidth / 2));
      canvas.drawLine(dividerP1, dividerP2, dividerPaint);
    }
    _painter!.paint(canvas, _currentRect!.topLeft, configuration);
  }

  Rect _applyStretchEffect(Rect rect) {
    if (controller.animation!.isCompleted) {
      return rect;
    }

    final double index = controller.index.toDouble();
    final double value = controller.animation!.value;

    late double tabChangeProgress;

    if (controller.indexIsChanging) {
      double progressLeft = (index - value).abs();
      final int tabsDelta = (controller.index - controller.previousIndex).abs();
      if (tabsDelta != 0) {
        progressLeft /= tabsDelta;
      }
      tabChangeProgress = 1 - clampDouble(progressLeft, 0.0, 1.0);
    } else {
      tabChangeProgress = (index - value).abs();
    }

    if (tabChangeProgress == 1.0) {
      return rect;
    }

    final double stretchSize = rect.width;

    final double inflationPerSide =
        stretchSize * _stretchAnimation.transform(tabChangeProgress) / 2;
    final Rect stretchedRect = _inflateRectHorizontally(rect, inflationPerSide);
    return stretchedRect;
  }

  late final Animatable<double> _stretchAnimation = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: 20,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: 80,
      ),
    ],
  );

  Rect _inflateRectHorizontally(Rect r, double delta) {
    return Rect.fromLTRB(r.left - delta, r.top, r.right + delta, r.bottom);
  }

  @override
  bool shouldRepaint(_IndicatorPainter old) {
    return _needsPaint ||
        controller != old.controller ||
        indicator != old.indicator ||
        tabKeys.length != old.tabKeys.length ||
        (!listEquals(_currentTabOffsets, old._currentTabOffsets)) ||
        _currentTextDirection != old._currentTextDirection;
  }
}

class _ChangeAnimation extends Animation<double>
    with AnimationWithParentMixin<double> {
  _ChangeAnimation(this.controller);

  final TabController controller;

  @override
  Animation<double> get parent => controller.animation!;

  @override
  void removeStatusListener(AnimationStatusListener listener) {
    if (controller.animation != null) {
      super.removeStatusListener(listener);
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    if (controller.animation != null) {
      super.removeListener(listener);
    }
  }

  @override
  double get value => _indexChangeProgress(controller);
}

class _DragAnimation extends Animation<double>
    with AnimationWithParentMixin<double> {
  _DragAnimation(this.controller, this.index);

  final TabController controller;
  final int index;

  @override
  Animation<double> get parent => controller.animation!;

  @override
  void removeStatusListener(AnimationStatusListener listener) {
    if (controller.animation != null) {
      super.removeStatusListener(listener);
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    if (controller.animation != null) {
      super.removeListener(listener);
    }
  }

  @override
  double get value {
    assert(!controller.indexIsChanging);
    final double controllerMaxValue = (controller.length - 1).toDouble();
    final double controllerValue =
        clampDouble(controller.animation!.value, 0.0, controllerMaxValue);
    return clampDouble((controllerValue - index.toDouble()).abs(), 0.0, 1.0);
  }
}

class _TabBarScrollPosition extends ScrollPositionWithSingleContext {
  _TabBarScrollPosition({
    required super.physics,
    required super.context,
    required super.oldPosition,
    required this.tabBar,
  }) : super(
          initialPixels: null,
        );

  final _CustomTabBarState tabBar;

  bool _viewportDimensionWasNonZero = false;

  bool _needsPixelsCorrection = true;

  @override
  bool applyContentDimensions(double minScrollExtent, double maxScrollExtent) {
    bool result = true;
    if (!_viewportDimensionWasNonZero) {
      _viewportDimensionWasNonZero = viewportDimension != 0.0;
    }
    if (!_viewportDimensionWasNonZero || _needsPixelsCorrection) {
      _needsPixelsCorrection = false;
      correctPixels(tabBar._initialScrollOffset(
          viewportDimension, minScrollExtent, maxScrollExtent));
      result = false;
    }
    return super.applyContentDimensions(minScrollExtent, maxScrollExtent) &&
        result;
  }

  void markNeedsPixelsCorrection() {
    _needsPixelsCorrection = true;
  }
}

class _TabBarScrollController extends ScrollController {
  _TabBarScrollController(this.tabBar);

  final _CustomTabBarState tabBar;

  @override
  ScrollPosition createScrollPosition(ScrollPhysics physics,
      ScrollContext context, ScrollPosition? oldPosition) {
    return _TabBarScrollPosition(
      physics: physics,
      context: context,
      oldPosition: oldPosition,
      tabBar: tabBar,
    );
  }
}

class CustomTabBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.padding,
    this.indicatorColor,
    this.automaticIndicatorColorAdjustment = true,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.indicatorSize,
    this.dividerColor,
    this.dividerHeight,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.overlayColor,
    this.mouseCursor,
    this.enableFeedback,
    this.onTap,
    this.onTapDown,
    this.onLongPress,
    this.physics,
    this.splashFactory,
    this.splashBorderRadius,
    this.tabAlignment,
    this.textScaler,
  })  : _isPrimary = true,
        assert(indicator != null || (indicatorWeight > 0.0));

  const CustomTabBar.secondary({
    super.key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.padding,
    this.indicatorColor,
    this.automaticIndicatorColorAdjustment = true,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.indicatorSize,
    this.dividerColor,
    this.dividerHeight,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.overlayColor,
    this.mouseCursor,
    this.enableFeedback,
    this.onTap,
    this.onTapDown,
    this.onLongPress,
    this.physics,
    this.splashFactory,
    this.splashBorderRadius,
    this.tabAlignment,
    this.textScaler,
  })  : _isPrimary = false,
        assert(indicator != null || (indicatorWeight > 0.0));

  final List<Widget> tabs;

  final TabController? controller;

  final bool isScrollable;

  final EdgeInsetsGeometry? padding;

  final Color? indicatorColor;

  final double indicatorWeight;

  final EdgeInsetsGeometry indicatorPadding;

  final Decoration? indicator;

  final bool automaticIndicatorColorAdjustment;

  final TabBarIndicatorSize? indicatorSize;

  final Color? dividerColor;

  final double? dividerHeight;

  final Color? labelColor;

  final Color? unselectedLabelColor;

  final TextStyle? labelStyle;

  final TextStyle? unselectedLabelStyle;

  final EdgeInsetsGeometry? labelPadding;

  final MaterialStateProperty<Color?>? overlayColor;

  final DragStartBehavior dragStartBehavior;

  final MouseCursor? mouseCursor;

  final bool? enableFeedback;

  final ValueChanged<int>? onTap;

  final void Function(TapDownDetails, int)? onTapDown;

  final void Function(int)? onLongPress;

  final ScrollPhysics? physics;

  final InteractiveInkFeatureFactory? splashFactory;

  final BorderRadius? splashBorderRadius;

  final TabAlignment? tabAlignment;

  final TextScaler? textScaler;

  @override
  Size get preferredSize {
    double maxHeight = _kTabHeight;
    for (final Widget item in tabs) {
      if (item is PreferredSizeWidget) {
        final double itemHeight = item.preferredSize.height;
        maxHeight = math.max(itemHeight, maxHeight);
      }
    }
    return Size.fromHeight(maxHeight + indicatorWeight);
  }

  bool get tabHasTextAndIcon {
    for (final Widget item in tabs) {
      if (item is PreferredSizeWidget) {
        if (item.preferredSize.height == _kTextAndIconTabHeight) {
          return true;
        }
      }
    }
    return false;
  }

  final bool _isPrimary;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  ScrollController? _scrollController;
  TabController? _controller;
  _IndicatorPainter? _indicatorPainter;
  int? _currentIndex;
  late double _tabStripWidth;
  late List<GlobalKey> _tabKeys;
  late List<EdgeInsetsGeometry> _labelPaddings;
  bool _debugHasScheduledValidTabsCountCheck = false;

  @override
  void initState() {
    super.initState();
    _tabKeys = widget.tabs.map((Widget tab) => GlobalKey()).toList();
    _labelPaddings = List<EdgeInsetsGeometry>.filled(
        widget.tabs.length, EdgeInsets.zero,
        growable: true);
  }

  TabBarTheme get _defaults {
    if (Theme.of(context).useMaterial3) {
      return widget._isPrimary
          ? _TabsPrimaryDefaultsM3(context, widget.isScrollable)
          : _TabsSecondaryDefaultsM3(context, widget.isScrollable);
    } else {
      return _TabsDefaultsM2(context, widget.isScrollable);
    }
  }

  Decoration _getIndicator(TabBarIndicatorSize indicatorSize) {
    final ThemeData theme = Theme.of(context);
    final TabBarTheme tabBarTheme = TabBarTheme.of(context);

    if (widget.indicator != null) {
      return widget.indicator!;
    }
    if (tabBarTheme.indicator != null) {
      return tabBarTheme.indicator!;
    }

    Color color = widget.indicatorColor ??
        tabBarTheme.indicatorColor ??
        _defaults.indicatorColor!;

    if (widget.automaticIndicatorColorAdjustment &&
        color.value == Material.maybeOf(context)?.color?.value) {
      color = Colors.white;
    }

    final double effectiveIndicatorWeight = theme.useMaterial3
        ? math.max(
            widget.indicatorWeight,
            switch (widget._isPrimary) {
              true => _TabsPrimaryDefaultsM3.indicatorWeight(indicatorSize),
              false => _TabsSecondaryDefaultsM3.indicatorWeight,
            },
          )
        : widget.indicatorWeight;

    final bool primaryWithLabelIndicator = switch (indicatorSize) {
      TabBarIndicatorSize.label => widget._isPrimary,
      TabBarIndicatorSize.tab => false,
    };
    final BorderRadius? effectiveBorderRadius =
        theme.useMaterial3 && primaryWithLabelIndicator
            ? BorderRadius.only(
                topLeft: Radius.circular(effectiveIndicatorWeight),
                topRight: Radius.circular(effectiveIndicatorWeight),
              )
            : null;
    return UnderlineTabIndicator(
      borderRadius: effectiveBorderRadius,
      borderSide: BorderSide(
        width: effectiveIndicatorWeight,
        color: color,
      ),
    );
  }

  bool get _controllerIsValid => _controller?.animation != null;

  void _updateTabController() {
    final TabController? newController =
        widget.controller ?? DefaultTabController.maybeOf(context);
    assert(() {
      if (newController == null) {
        throw FlutterError(
          'No TabController for ${widget.runtimeType}.\n'
          'When creating a ${widget.runtimeType}, you must either provide an explicit '
          'TabController using the "controller" property, or you must ensure that there '
          'is a DefaultTabController above the ${widget.runtimeType}.\n'
          'In this case, there was neither an explicit controller nor a default controller.',
        );
      }
      return true;
    }());

    if (newController == _controller) {
      return;
    }

    if (_controllerIsValid) {
      _controller!.animation!.removeListener(_handleTabControllerAnimationTick);
      _controller!.removeListener(_handleTabControllerTick);
    }
    _controller = newController;
    if (_controller != null) {
      _controller!.animation!.addListener(_handleTabControllerAnimationTick);
      _controller!.addListener(_handleTabControllerTick);
      _currentIndex = _controller!.index;
    }
  }

  void _initIndicatorPainter() {
    final ThemeData theme = Theme.of(context);
    final TabBarTheme tabBarTheme = TabBarTheme.of(context);
    final TabBarIndicatorSize indicatorSize = widget.indicatorSize ??
        tabBarTheme.indicatorSize ??
        _defaults.indicatorSize!;

    final _IndicatorPainter? oldPainter = _indicatorPainter;

    _indicatorPainter = !_controllerIsValid
        ? null
        : _IndicatorPainter(
            controller: _controller!,
            indicator: _getIndicator(indicatorSize),
            indicatorSize: indicatorSize,
            indicatorPadding: widget.indicatorPadding,
            tabKeys: _tabKeys,
            old: oldPainter,
            labelPaddings: _labelPaddings,
            dividerColor: widget.dividerColor ??
                tabBarTheme.dividerColor ??
                _defaults.dividerColor,
            dividerHeight: widget.dividerHeight ??
                tabBarTheme.dividerHeight ??
                _defaults.dividerHeight,
            showDivider: theme.useMaterial3 && !widget.isScrollable,
            devicePixelRatio: MediaQuery.devicePixelRatioOf(context),
          );

    oldPainter?.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    assert(debugCheckHasMaterial(context));
    _updateTabController();
    _initIndicatorPainter();
  }

  @override
  void didUpdateWidget(CustomTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController();
      _initIndicatorPainter();

      if (_scrollController != null && _scrollController!.hasClients) {
        final ScrollPosition position = _scrollController!.position;
        if (position is _TabBarScrollPosition) {
          position.markNeedsPixelsCorrection();
        }
      }
    } else if (widget.indicatorColor != oldWidget.indicatorColor ||
        widget.indicatorWeight != oldWidget.indicatorWeight ||
        widget.indicatorSize != oldWidget.indicatorSize ||
        widget.indicatorPadding != oldWidget.indicatorPadding ||
        widget.indicator != oldWidget.indicator ||
        widget.dividerColor != oldWidget.dividerColor ||
        widget.dividerHeight != oldWidget.dividerHeight) {
      _initIndicatorPainter();
    }

    if (widget.tabs.length > _tabKeys.length) {
      final int delta = widget.tabs.length - _tabKeys.length;
      _tabKeys.addAll(List<GlobalKey>.generate(delta, (int n) => GlobalKey()));
      _labelPaddings
          .addAll(List<EdgeInsetsGeometry>.filled(delta, EdgeInsets.zero));
    } else if (widget.tabs.length < _tabKeys.length) {
      _tabKeys.removeRange(widget.tabs.length, _tabKeys.length);
      _labelPaddings.removeRange(widget.tabs.length, _tabKeys.length);
    }
  }

  @override
  void dispose() {
    _indicatorPainter!.dispose();
    if (_controllerIsValid) {
      _controller!.animation!.removeListener(_handleTabControllerAnimationTick);
      _controller!.removeListener(_handleTabControllerTick);
    }
    _controller = null;
    _scrollController?.dispose();

    super.dispose();
  }

  int get maxTabIndex => _indicatorPainter!.maxTabIndex;

  double _tabScrollOffset(
      int index, double viewportWidth, double minExtent, double maxExtent) {
    if (!widget.isScrollable) {
      return 0.0;
    }
    double tabCenter = _indicatorPainter!.centerOf(index);
    double paddingStart;
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        paddingStart = widget.padding?.resolve(TextDirection.rtl).right ?? 0;
        tabCenter = _tabStripWidth - tabCenter;
      case TextDirection.ltr:
        paddingStart = widget.padding?.resolve(TextDirection.ltr).left ?? 0;
    }

    return clampDouble(
        tabCenter + paddingStart - viewportWidth / 2.0, minExtent, maxExtent);
  }

  double _tabCenteredScrollOffset(int index) {
    final ScrollPosition position = _scrollController!.position;
    return _tabScrollOffset(index, position.viewportDimension,
        position.minScrollExtent, position.maxScrollExtent);
  }

  double _initialScrollOffset(
      double viewportWidth, double minExtent, double maxExtent) {
    return _tabScrollOffset(
        _currentIndex!, viewportWidth, minExtent, maxExtent);
  }

  void _scrollToCurrentIndex() {
    final double offset = _tabCenteredScrollOffset(_currentIndex!);
    _scrollController!
        .animateTo(offset, duration: kTabScrollDuration, curve: Curves.ease);
  }

  void _scrollToControllerValue() {
    final double? leadingPosition = _currentIndex! > 0
        ? _tabCenteredScrollOffset(_currentIndex! - 1)
        : null;
    final double middlePosition = _tabCenteredScrollOffset(_currentIndex!);
    final double? trailingPosition = _currentIndex! < maxTabIndex
        ? _tabCenteredScrollOffset(_currentIndex! + 1)
        : null;

    final double index = _controller!.index.toDouble();
    final double value = _controller!.animation!.value;
    final double offset = switch (value - index) {
      -1.0 => leadingPosition ?? middlePosition,
      1.0 => trailingPosition ?? middlePosition,
      0 => middlePosition,
      < 0 => leadingPosition == null
          ? middlePosition
          : lerpDouble(middlePosition, leadingPosition, index - value)!,
      _ => trailingPosition == null
          ? middlePosition
          : lerpDouble(middlePosition, trailingPosition, value - index)!,
    };

    _scrollController!.jumpTo(offset);
  }

  void _handleTabControllerAnimationTick() {
    assert(mounted);
    if (!_controller!.indexIsChanging && widget.isScrollable) {
      _currentIndex = _controller!.index;
      _scrollToControllerValue();
    }
  }

  void _handleTabControllerTick() {
    if (_controller!.index != _currentIndex) {
      _currentIndex = _controller!.index;
      if (widget.isScrollable) {
        _scrollToCurrentIndex();
      }
    }
    setState(() {});
  }

  void _saveTabOffsets(
      List<double> tabOffsets, TextDirection textDirection, double width) {
    _tabStripWidth = width;
    _indicatorPainter?.saveTabOffsets(tabOffsets, textDirection);
  }

  void _handleTap(int index) {
    assert(index >= 0 && index < widget.tabs.length);
    _controller!.animateTo(index);
    widget.onTap?.call(index);
  }

  Widget _buildStyledTab(Widget child, bool isSelected,
      Animation<double> animation, TabBarTheme defaults) {
    return _TabStyle(
      animation: animation,
      isSelected: isSelected,
      isPrimary: widget._isPrimary,
      labelColor: widget.labelColor,
      unselectedLabelColor: widget.unselectedLabelColor,
      labelStyle: widget.labelStyle,
      unselectedLabelStyle: widget.unselectedLabelStyle,
      defaults: defaults,
      child: child,
    );
  }

  bool _debugScheduleCheckHasValidTabsCount() {
    if (_debugHasScheduledValidTabsCountCheck) {
      return true;
    }
    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      _debugHasScheduledValidTabsCountCheck = false;
      if (!mounted) {
        return;
      }
      assert(() {
        if (_controller!.length != widget.tabs.length) {
          throw FlutterError(
            "Controller's length property (${_controller!.length}) does not match the "
            "number of tabs (${widget.tabs.length}) present in TabBar's tabs property.",
          );
        }
        return true;
      }());
    }, debugLabel: 'TabBar.tabsCountCheck');
    _debugHasScheduledValidTabsCountCheck = true;
    return true;
  }

  bool _debugTabAlignmentIsValid(TabAlignment tabAlignment) {
    assert(() {
      if (widget.isScrollable && tabAlignment == TabAlignment.fill) {
        throw FlutterError(
          '$tabAlignment is only valid for non-scrollable tab bars.',
        );
      }
      if (!widget.isScrollable &&
          (tabAlignment == TabAlignment.start ||
              tabAlignment == TabAlignment.startOffset)) {
        throw FlutterError(
          '$tabAlignment is only valid for scrollable tab bars.',
        );
      }
      return true;
    }());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    assert(_debugScheduleCheckHasValidTabsCount());
    final ThemeData theme = Theme.of(context);
    final TabBarTheme tabBarTheme = TabBarTheme.of(context);
    final TabAlignment effectiveTabAlignment = widget.tabAlignment ??
        tabBarTheme.tabAlignment ??
        _defaults.tabAlignment!;
    assert(_debugTabAlignmentIsValid(effectiveTabAlignment));

    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    if (_controller!.length == 0) {
      return Container(
        height: _kTabHeight + widget.indicatorWeight,
      );
    }

    final List<Widget> wrappedTabs =
        List<Widget>.generate(widget.tabs.length, (int index) {
      const double verticalAdjustment =
          (_kTextAndIconTabHeight - _kTabHeight) / 2.0;
      EdgeInsetsGeometry? adjustedPadding;

      if (widget.tabs[index] is PreferredSizeWidget) {
        final PreferredSizeWidget tab =
            widget.tabs[index] as PreferredSizeWidget;
        if (widget.tabHasTextAndIcon &&
            tab.preferredSize.height == _kTabHeight) {
          if (widget.labelPadding != null || tabBarTheme.labelPadding != null) {
            adjustedPadding = (widget.labelPadding ?? tabBarTheme.labelPadding!)
                .add(const EdgeInsets.symmetric(vertical: verticalAdjustment));
          } else {
            adjustedPadding = const EdgeInsets.symmetric(
                vertical: verticalAdjustment, horizontal: 16.0);
          }
        }
      }

      _labelPaddings[index] = adjustedPadding ??
          widget.labelPadding ??
          tabBarTheme.labelPadding ??
          kTabLabelPadding;

      return Center(
        heightFactor: 1.0,
        child: Padding(
          padding: _labelPaddings[index],
          child: KeyedSubtree(
            key: _tabKeys[index],
            child: widget.tabs[index],
          ),
        ),
      );
    });

    if (_controller != null) {
      final int previousIndex = _controller!.previousIndex;

      if (_controller!.indexIsChanging) {
        assert(_currentIndex != previousIndex);
        final Animation<double> animation = _ChangeAnimation(_controller!);
        wrappedTabs[_currentIndex!] = _buildStyledTab(
            wrappedTabs[_currentIndex!], true, animation, _defaults);
        wrappedTabs[previousIndex] = _buildStyledTab(
            wrappedTabs[previousIndex], false, animation, _defaults);
      } else {
        final int tabIndex = _currentIndex!;
        final Animation<double> centerAnimation =
            _DragAnimation(_controller!, tabIndex);
        wrappedTabs[tabIndex] = _buildStyledTab(
            wrappedTabs[tabIndex], true, centerAnimation, _defaults);
        if (_currentIndex! > 0) {
          final int tabIndex = _currentIndex! - 1;
          final Animation<double> previousAnimation =
              ReverseAnimation(_DragAnimation(_controller!, tabIndex));
          wrappedTabs[tabIndex] = _buildStyledTab(
              wrappedTabs[tabIndex], false, previousAnimation, _defaults);
        }
        if (_currentIndex! < widget.tabs.length - 1) {
          final int tabIndex = _currentIndex! + 1;
          final Animation<double> nextAnimation =
              ReverseAnimation(_DragAnimation(_controller!, tabIndex));
          wrappedTabs[tabIndex] = _buildStyledTab(
              wrappedTabs[tabIndex], false, nextAnimation, _defaults);
        }
      }
    }

    final int tabCount = widget.tabs.length;
    for (int index = 0; index < tabCount; index += 1) {
      final Set<MaterialState> selectedState = <MaterialState>{
        if (index == _currentIndex) MaterialState.selected,
      };

      final MouseCursor effectiveMouseCursor =
          MaterialStateProperty.resolveAs<MouseCursor?>(
                  widget.mouseCursor, selectedState) ??
              tabBarTheme.mouseCursor?.resolve(selectedState) ??
              MaterialStateMouseCursor.clickable.resolve(selectedState);

      final MaterialStateProperty<Color?> defaultOverlay =
          MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          final Set<MaterialState> effectiveStates = selectedState
            ..addAll(states);
          return _defaults.overlayColor?.resolve(effectiveStates);
        },
      );
      wrappedTabs[index] = InkWell(
        mouseCursor: effectiveMouseCursor,
        onTap: () {
          _handleTap(index);
        },
        onTapDown: widget.onTapDown != null
            ? (details) => widget.onTapDown!(details, index)
            : null,
        onLongPress: widget.onLongPress != null
            ? () => widget.onLongPress!(index)
            : null,
        enableFeedback: widget.enableFeedback ?? true,
        overlayColor:
            widget.overlayColor ?? tabBarTheme.overlayColor ?? defaultOverlay,
        splashFactory: widget.splashFactory ??
            tabBarTheme.splashFactory ??
            _defaults.splashFactory,
        borderRadius: widget.splashBorderRadius,
        child: Padding(
          padding: EdgeInsets.only(bottom: widget.indicatorWeight),
          child: Stack(
            children: <Widget>[
              wrappedTabs[index],
              Semantics(
                selected: index == _currentIndex,
                label: localizations.tabLabel(
                    tabIndex: index + 1, tabCount: tabCount),
              ),
            ],
          ),
        ),
      );
      if (!widget.isScrollable && effectiveTabAlignment == TabAlignment.fill) {
        wrappedTabs[index] = Expanded(child: wrappedTabs[index]);
      }
    }

    Widget tabBar = CustomPaint(
      painter: _indicatorPainter,
      child: _TabStyle(
        animation: kAlwaysDismissedAnimation,
        isSelected: false,
        isPrimary: widget._isPrimary,
        labelColor: widget.labelColor,
        unselectedLabelColor: widget.unselectedLabelColor,
        labelStyle: widget.labelStyle,
        unselectedLabelStyle: widget.unselectedLabelStyle,
        defaults: _defaults,
        child: _TabLabelBar(
          onPerformLayout: _saveTabOffsets,
          mainAxisSize: effectiveTabAlignment == TabAlignment.fill
              ? MainAxisSize.max
              : MainAxisSize.min,
          children: wrappedTabs,
        ),
      ),
    );

    if (widget.isScrollable) {
      final EdgeInsetsGeometry? effectivePadding =
          effectiveTabAlignment == TabAlignment.startOffset
              ? const EdgeInsetsDirectional.only(start: _kStartOffset)
                  .add(widget.padding ?? EdgeInsets.zero)
              : widget.padding;
      _scrollController ??= _TabBarScrollController(this);
      tabBar = ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
        child: SingleChildScrollView(
          dragStartBehavior: widget.dragStartBehavior,
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          padding: effectivePadding,
          physics: widget.physics,
          child: tabBar,
        ),
      );
      if (theme.useMaterial3) {
        final AlignmentGeometry effectiveAlignment =
            switch (effectiveTabAlignment) {
          TabAlignment.center => Alignment.center,
          TabAlignment.start ||
          TabAlignment.startOffset ||
          TabAlignment.fill =>
            AlignmentDirectional.centerStart,
        };

        final Color dividerColor = widget.dividerColor ??
            tabBarTheme.dividerColor ??
            _defaults.dividerColor!;
        final double dividerHeight = widget.dividerHeight ??
            tabBarTheme.dividerHeight ??
            _defaults.dividerHeight!;

        tabBar = Align(
          heightFactor: 1.0,
          widthFactor: dividerHeight > 0 ? null : 1.0,
          alignment: effectiveAlignment,
          child: tabBar,
        );

        if (dividerColor != Colors.transparent && dividerHeight > 0) {
          tabBar = CustomPaint(
            painter: _DividerPainter(
              dividerColor: dividerColor,
              dividerHeight: widget.dividerHeight ??
                  tabBarTheme.dividerHeight ??
                  _defaults.dividerHeight!,
            ),
            child: tabBar,
          );
        }
      }
    } else if (widget.padding != null) {
      tabBar = Padding(
        padding: widget.padding!,
        child: tabBar,
      );
    }

    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: widget.textScaler ?? tabBarTheme.textScaler),
      child: tabBar,
    );
  }
}

class _TabsDefaultsM2 extends TabBarTheme {
  const _TabsDefaultsM2(this.context, this.isScrollable)
      : super(indicatorSize: TabBarIndicatorSize.tab);

  final BuildContext context;
  final bool isScrollable;

  @override
  Color? get indicatorColor => Theme.of(context).indicatorColor;

  @override
  Color? get labelColor => Theme.of(context).primaryTextTheme.bodyLarge!.color!;

  @override
  TextStyle? get labelStyle => Theme.of(context).primaryTextTheme.bodyLarge;

  @override
  TextStyle? get unselectedLabelStyle =>
      Theme.of(context).primaryTextTheme.bodyLarge;

  @override
  InteractiveInkFeatureFactory? get splashFactory =>
      Theme.of(context).splashFactory;

  @override
  TabAlignment? get tabAlignment =>
      isScrollable ? TabAlignment.start : TabAlignment.fill;
}

class _TabsPrimaryDefaultsM3 extends TabBarTheme {
  _TabsPrimaryDefaultsM3(this.context, this.isScrollable)
      : super(indicatorSize: TabBarIndicatorSize.label);

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;
  final bool isScrollable;

  @override
  Color? get dividerColor => _colors.outlineVariant;

  @override
  double? get dividerHeight => 1.0;

  @override
  Color? get indicatorColor => _colors.primary;

  @override
  Color? get labelColor => _colors.primary;

  @override
  TextStyle? get labelStyle => _textTheme.titleSmall;

  @override
  Color? get unselectedLabelColor => _colors.onSurfaceVariant;

  @override
  TextStyle? get unselectedLabelStyle => _textTheme.titleSmall;

  @override
  MaterialStateProperty<Color?> get overlayColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        if (states.contains(MaterialState.pressed)) {
          return _colors.primary.withOpacity(0.1);
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.primary.withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.primary.withOpacity(0.1);
        }
        return null;
      }
      if (states.contains(MaterialState.pressed)) {
        return _colors.primary.withOpacity(0.1);
      }
      if (states.contains(MaterialState.hovered)) {
        return _colors.onSurface.withOpacity(0.08);
      }
      if (states.contains(MaterialState.focused)) {
        return _colors.onSurface.withOpacity(0.1);
      }
      return null;
    });
  }

  @override
  InteractiveInkFeatureFactory? get splashFactory =>
      Theme.of(context).splashFactory;

  @override
  TabAlignment? get tabAlignment =>
      isScrollable ? TabAlignment.startOffset : TabAlignment.fill;

  static double indicatorWeight(TabBarIndicatorSize indicatorSize) {
    return switch (indicatorSize) {
      TabBarIndicatorSize.label => 3.0,
      TabBarIndicatorSize.tab => 2.0,
    };
  }
}

class _TabsSecondaryDefaultsM3 extends TabBarTheme {
  _TabsSecondaryDefaultsM3(this.context, this.isScrollable)
      : super(indicatorSize: TabBarIndicatorSize.tab);

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;
  final bool isScrollable;

  @override
  Color? get dividerColor => _colors.outlineVariant;

  @override
  double? get dividerHeight => 1.0;

  @override
  Color? get indicatorColor => _colors.primary;

  @override
  Color? get labelColor => _colors.onSurface;

  @override
  TextStyle? get labelStyle => _textTheme.titleSmall;

  @override
  Color? get unselectedLabelColor => _colors.onSurfaceVariant;

  @override
  TextStyle? get unselectedLabelStyle => _textTheme.titleSmall;

  @override
  MaterialStateProperty<Color?> get overlayColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        if (states.contains(MaterialState.pressed)) {
          return _colors.onSurface.withOpacity(0.1);
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.onSurface.withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.onSurface.withOpacity(0.1);
        }
        return null;
      }
      if (states.contains(MaterialState.pressed)) {
        return _colors.onSurface.withOpacity(0.1);
      }
      if (states.contains(MaterialState.hovered)) {
        return _colors.onSurface.withOpacity(0.08);
      }
      if (states.contains(MaterialState.focused)) {
        return _colors.onSurface.withOpacity(0.1);
      }
      return null;
    });
  }

  @override
  InteractiveInkFeatureFactory? get splashFactory =>
      Theme.of(context).splashFactory;

  @override
  TabAlignment? get tabAlignment =>
      isScrollable ? TabAlignment.startOffset : TabAlignment.fill;

  static double indicatorWeight = 2.0;
}
