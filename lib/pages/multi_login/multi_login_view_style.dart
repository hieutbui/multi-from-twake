import 'package:flutter/material.dart';

class MultiLoginViewStyle {
  static const EdgeInsetsGeometry padding =
      EdgeInsets.symmetric(horizontal: 20.0);

  static const BoxDecoration decoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment(0.50, -0.00),
      end: Alignment(0.50, 1.00),
      colors: [Color(0xFF0E0F13), Color(0xFF191B26)],
    ),
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
