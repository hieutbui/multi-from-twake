import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/utils/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';

class TwakeContextMenuStyle {
  static Color? defaultMenuColor(BuildContext context) {
    return LinagoraRefColors.material().primary[100];
  }

  static Color? defaultItemColorIcon(BuildContext context) {
    return MultiColors.of(context).textMainPrimaryDefault;
  }

  static const BorderRadiusGeometry defaultMenuBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
  );

  static const double defaultVerticalPadding = 0.0;
  static const double menuElevation = 2.0;
  static const double menuBorderRadius = 20.0;
  static const double menuMinWidth = 196.0;
  static const double menuMaxWidth = 306.0;
  static const double defaultItemIconSize = 24.0;
  static const EdgeInsets defaultItemPadding = EdgeInsets.symmetric(
    vertical: 11.0,
    horizontal: 16.0,
  );
  static const double defaultItemElementsGap = 12.0;

  static TextStyle? defaultItemTextStyle(BuildContext context) {
    return context.textTheme.bodyLarge!
        .copyWith(color: LinagoraRefColors.material().neutral[30]);
  }
}
