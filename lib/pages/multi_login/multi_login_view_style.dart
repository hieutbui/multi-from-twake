import 'package:flutter/material.dart';

class MultiLoginViewStyle {
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
