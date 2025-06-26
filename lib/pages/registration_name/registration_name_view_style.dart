import 'package:flutter/material.dart';

class RegistrationNameViewStyle {
  static BorderRadius nameTextFieldBorderRadius =
      const BorderRadius.all(Radius.circular(8));

  static const BoxDecoration decoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF0E0F13), Color(0xFF191B26)],
    ),
  );

  static BoxDecoration helloContainerDecoration = BoxDecoration(
    color: const Color(0xFF374151).withAlpha(153),
    borderRadius: const BorderRadius.all(
      Radius.circular(20.0),
    ),
  );

  static InputDecoration nameTextFieldDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: nameTextFieldBorderRadius,
      borderSide: BorderSide(
        color: Colors.white.withAlpha(60),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: nameTextFieldBorderRadius,
      borderSide: BorderSide(
        color: Colors.white.withAlpha(60),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: nameTextFieldBorderRadius,
      borderSide: BorderSide(
        color: Colors.white.withAlpha(120),
      ),
    ),
    hintText: 'Enter your last name',
    hintStyle: TextStyle(
      color: Colors.white.withAlpha(80),
      fontSize: 18,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
  );
}
