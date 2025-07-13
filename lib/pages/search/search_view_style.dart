import 'package:flutter/material.dart';

class SearchViewStyle {
  static double get toolbarHeightSearch => 90.0;

  static double get toolbarHeightOfSliverAppBar => 44.0;

  static EdgeInsetsGeometry get paddingRecentChatsHeaders =>
      const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0);

  static EdgeInsetsGeometry get paddingLeadingAppBar =>
      const EdgeInsetsDirectional.only(end: 8, start: 8);

  static EdgeInsetsGeometry get contentPaddingAppBar =>
      const EdgeInsets.all(12.0);

  static EdgeInsetsGeometry get paddingRecentChats => const EdgeInsets.all(8);

  static const double paddingBackButton = 8.0;

  static final BorderRadius borderRadiusTextField = BorderRadius.circular(24);

  static EdgeInsetsGeometry get appbarPadding =>
      const EdgeInsetsDirectional.only(
        bottom: 0.0,
        top: 0.0,
      );

  static TextStyle? headerTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          );

  static const double searchIconSize = 24.0;
}
