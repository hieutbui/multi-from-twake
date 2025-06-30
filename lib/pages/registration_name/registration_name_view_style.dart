import 'package:flutter/material.dart';

class RegistrationNameViewStyle {
  static BorderRadius nameTextFieldBorderRadius =
      const BorderRadius.all(Radius.circular(8));

  static const BoxDecoration decoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF0E0F13),
        Color(0xFF191B26),
      ],
    ),
  );
  static BoxDecoration helloContainerDecoration = BoxDecoration(
    color: const Color(0xFF374151).withAlpha(153),
    borderRadius: const BorderRadius.all(
      Radius.circular(20.0),
    ),
  );
}
