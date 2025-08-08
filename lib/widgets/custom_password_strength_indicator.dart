import 'package:flutter/material.dart';
import 'package:password_strength_indicator/password_strength_indicator.dart';

class CustomPasswordStrengthIndicator extends PasswordStrengthIndicator {
  const CustomPasswordStrengthIndicator({
    super.key,
    required super.password,
    required super.colors,
    super.backgroundColor,
    super.duration,
    super.thickness,
    super.width,
    super.radius,
    super.callback,
    super.strengthBuilder,
    super.curve,
    super.style,
  });

  @override
  State<CustomPasswordStrengthIndicator> createState() =>
      _PasswordStrengthIndicatorState();
}

class _PasswordStrengthIndicatorState
    extends State<CustomPasswordStrengthIndicator>
    with SingleTickerProviderStateMixin {
  // Animation controller of the strength bar
  late AnimationController _animationController;

  // Animation of the strength bar
  late Animation<double> _animation;

  // Strength of the password
  late double _strength;

  // Width of the strength bar
  late double? _width;

  // Thickness of the strength bar
  late double _thickness;

  // Background color of the strength bar
  late Color _backgroundColor;

  // Radius of the strength bar
  late double _radius;

  // Colors of the strength bar
  late StrengthColors _colors;

  // Strength callback
  void Function(double strength)? _callback;

  // Strength builder
  double Function(String password)? _strengthBuilder;

  // begin of the animation
  late double _begin = 0.0;

  // end of the animation
  late double _end = 0.0;

  // Active color of the strength bar
  late Color _activeColor;

  // Strength bar style
  late StrengthBarStyle _style;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Initialize the animation
    _animation = Tween<double>(
      begin: _begin,
      end: _begin,
    ).animate(_animationController);

    // Initialize the strength
    _strength = 0.0;

    // Initialize the width
    _width = widget.width;

    // Initialize the thickness
    _thickness = widget.thickness;

    // Initialize the background color
    _backgroundColor = widget.backgroundColor;

    // Initialize the radius
    _radius = widget.radius;

    // Initialize the colors
    _colors = widget.colors;

    // Initialize the callback
    _callback = widget.callback;

    // Initialize the strength builder
    _strengthBuilder = widget.strengthBuilder;

    // Initialize the active color
    _activeColor = _colors.getColor(_strength);

    // Initialize the style
    _style = widget.style;

    // Start the animation
    _animationController.forward();
  }

  void animate() {
    // Calculate the strength
    _strength = _strengthBuilder != null
        ? _strengthBuilder!(widget.password ?? '')
        : estimatePasswordStrength(widget.password ?? '');

    _begin = _end;
    _end = _strength * 100;

    // Calculate the active color
    _activeColor = _colors.getColor(_strength);

    // Update the animation
    _animation = Tween<double>(
      begin: _begin,
      end: _end,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve,
      ),
    );

    // Start the animation
    _animationController.forward(from: 0);

    // Call the callback
    _callback?.call(_strength);
  }

  @override
  void didUpdateWidget(covariant CustomPasswordStrengthIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.password != widget.password) {
      animate();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StrengthBar(
      animation: _animation,
      width: _width,
      thickness: _thickness,
      backgroundColor: _backgroundColor,
      radius: _radius,
      colors: widget.colors,
      activeColor: _activeColor,
      style: _style,
    );
  }
}

class StrengthBar extends AnimatedWidget {
  // Width of the strength bar
  final double? width;

  // Thickness of the strength bar
  final double thickness;

  // Background color of the strength bar
  final Color backgroundColor;

  // Radius of the strength bar
  final double radius;

  // Colors of the strength bar
  final StrengthColors colors;

  // Active color of the strength bar
  final Color activeColor;

  // Style of the strength bar
  final StrengthBarStyle style;

  const StrengthBar({
    super.key,
    required Animation<double> animation,
    required this.width,
    required this.thickness,
    required this.backgroundColor,
    required this.radius,
    required this.colors,
    required this.activeColor,
    required this.style,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        switch (style) {
          case StrengthBarStyle.line:
            return CustomPaint(
              size: Size(width ?? constraints.maxWidth, thickness),
              painter: StrengthBarBackgroundPainter(
                color: backgroundColor,
                radius: radius,
              ),
              foregroundPainter: StrengthBarPainter(
                color: activeColor,
                radius: radius,
                percentage: (listenable as Animation<double>).value,
              ),
            );
          case StrengthBarStyle.dashed:
            return Row(
              children: [
                Flexible(
                  child: CustomPaint(
                    size: Size(width ?? constraints.maxWidth, thickness),
                    painter: StrengthBarBackgroundPainter(
                      color: backgroundColor,
                      radius: radius,
                    ),
                    foregroundPainter: StrengthBarDashedBarPainter(
                      color: colors.weak,
                      radius: radius,
                      dashCount: 1,
                      percentage: (listenable as Animation<double>).value,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: CustomPaint(
                    size: Size(width ?? constraints.maxWidth, thickness),
                    painter: StrengthBarBackgroundPainter(
                      color: backgroundColor,
                      radius: radius,
                    ),
                    foregroundPainter: StrengthBarDashedBarPainter(
                      color: colors.medium,
                      radius: radius,
                      dashCount: 2,
                      percentage: (listenable as Animation<double>).value,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: CustomPaint(
                    size: Size(width ?? constraints.maxWidth, thickness),
                    painter: StrengthBarBackgroundPainter(
                      color: backgroundColor,
                      radius: radius,
                    ),
                    foregroundPainter: StrengthBarDashedBarPainter(
                      color: colors.strong,
                      radius: radius,
                      dashCount: 3,
                      percentage: (listenable as Animation<double>).value,
                    ),
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}
