// reference to: https://pub.dev/packages/contextmenu
import 'package:fluffychat/widgets/mixins/twake_context_menu_mixin.dart';
import 'package:fluffychat/widgets/mixins/twake_context_menu_style.dart';
import 'package:flutter/material.dart';

import 'twake_context_menu.dart';

typedef ContextMenuBuilder = List<Widget> Function(BuildContext context);

/// The [TwakeContextMenuArea] is the way to use a [TwakeContextMenu]
///
/// It listens for right click and long press and executes [showTwakeContextMenu]
/// with the corresponding location [Offset].

class TwakeContextMenuArea extends StatelessWidget with TwakeContextMenuMixin {
  /// The widget displayed inside the [TwakeContextMenuArea]
  final Widget child;

  /// Builds a [List] of items to be displayed in an opened [TwakeContextMenu]
  ///
  /// Usually, a [ListTile] might be the way to go.
  final ContextMenuBuilder? builder;

  /// The padding value at the top an bottom between the edge of the [TwakeContextMenu] and the first / last item
  final double? verticalPadding;

  const TwakeContextMenuArea({
    Key? key,
    required this.child,
    this.builder,
    this.verticalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (builder == null) {
      return child;
    }
    return GestureDetector(
      onSecondaryTapDown: (details) => showTwakeContextMenu(
        offset: details.globalPosition,
        context: context,
        builder: builder!,
        verticalPadding:
            verticalPadding ?? TwakeContextMenuStyle.defaultVerticalPadding,
      ),
      child: child,
    );
  }
}
