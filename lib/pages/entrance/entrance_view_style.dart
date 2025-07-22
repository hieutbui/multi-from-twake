import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:flutter/material.dart';

class EntranceViewStyle {
  static const double shortSpacing = 12.0;
  static const double mediumSpacing = 32.0;
  static const double oauthButtonSeparator = 8.0;
  static const double oauthButtonIconSize = 18.0;
  static const double oauthButtonHeight = 48.0;

  static const EdgeInsetsGeometry padding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 40);
  static const EdgeInsetsGeometry logoPadding =
      EdgeInsets.symmetric(horizontal: 20);

  static Decoration backgroundDecoration = BoxDecoration(
    color: const MultiDarkColors().backgroundPageDefault,
    shape: BoxShape.rectangle,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
    ),
  );
}
