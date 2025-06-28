import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:flutter/material.dart';

class EntranceViewStyle {
  static const double shortSpacing = 12.0;
  static const double mediumSpacing = 32.0;

  static const EdgeInsetsGeometry padding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 40);
  static const EdgeInsetsGeometry logoPadding =
      EdgeInsets.symmetric(horizontal: 20);

  static const Decoration backgroundDecoration = BoxDecoration(
    color: MultiDarkColors.backgroundPageDefault,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
    ),
  );

  static TextStyle? welcomeTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.white.withAlpha(222),
          );

  static TextStyle? subtitleTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white.withAlpha(153),
            fontSize: 17,
            letterSpacing: -0.41,
            fontWeight: FontWeight.w400,
          );

  static TextStyle? buttonTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.black.withAlpha(222),
            /* Text-Reversed-Primary */
            fontSize: 17,
          );

  static TextStyle? buttonGreyTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white.withAlpha(222),
            /* Text-Main-Primary_Default */
            fontSize: 17,
          );

  static TextStyle? haveAccountTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.white.withAlpha(153),
            /* Text-Main-Secondary */
            fontSize: 17,
            letterSpacing: -0.41,
            fontWeight: FontWeight.w400,
          );

  static TextStyle? loginTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.white.withAlpha(222),
            /* Text-Main-Secondary */
            fontSize: 17,
            fontWeight: FontWeight.w400,
          );
}
