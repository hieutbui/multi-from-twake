import 'package:flutter/material.dart';

class EntranceViewStyle {
  static const double shortSpacing = 12.0;
  static const double mediumSpacing = 32.0;

  static const EdgeInsetsGeometry padding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 40);
  static const EdgeInsetsGeometry logoPadding =
      EdgeInsets.symmetric(horizontal: 20);

  static const Decoration backgroundDecoration = BoxDecoration(
    color: Color(0xFF171718), // Background-Page-Default
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
    ),
  );

  TextStyle? welcomeTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Colors.white.withAlpha(222),
            fontSize: 34,
            letterSpacing: 0.37,
          );

  TextStyle? subtitleTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white.withAlpha(153),
            fontSize: 17,
            letterSpacing: -0.41,
            fontWeight: FontWeight.w400,
          );

  TextStyle? buttonTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.black.withAlpha(222),
            /* Text-Reversed-Primary */
            fontSize: 17,
          );

  TextStyle? buttonGreyTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white.withAlpha(222),
            /* Text-Main-Primary_Default */
            fontSize: 17,
          );

  TextStyle? haveAccountTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.white.withAlpha(153),
            /* Text-Main-Secondary */
            fontSize: 17,
            letterSpacing: -0.41,
            fontWeight: FontWeight.w400,
          );

  TextStyle? loginTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.white.withAlpha(222),
            /* Text-Main-Secondary */
            fontSize: 17,
            fontWeight: FontWeight.w400,
          );
}
