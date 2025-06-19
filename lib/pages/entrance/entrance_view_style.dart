import 'package:flutter/material.dart';

class WelcomeStyle {
  // Spacing constants
  static const double topSpacing = 40.0;
  static const double titleSpacing = 60.0;
  static const double subtitleSpacing = 20.0;
  static const double buttonsSpacing = 64.0;
  static const double buttonSpacing = 20.0;
  static const double loginTextSpacing = 32.0;
  static const double bottomSpacing = 40.0;

  // Button styling
  static const double buttonHeight = 64.0;
  static const double buttonBorderRadius = 32.0;
  static const double buttonIconSize = 28.0;
  static const double buttonIconSpacing = 16.0;
  static const double buttonTextSize = 18.0;

  // Layout constants
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(horizontal: 32.0);
  static const double decorativeElementsHeight = 280.0;

  // Text styles
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 36.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: 'SF Pro',
    letterSpacing: -0.8,
    height: 1.1,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    color: Color(0xFFB3B3B3),
    fontFamily: 'SF Pro',
    letterSpacing: -0.5,
    height: 1.4,
  );

  static const TextStyle loginTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    fontFamily: 'SF Pro',
    letterSpacing: -0.41,
    height: 1.25,
  );

  static const TextStyle loginLinkTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Color(0xFF007AFF),
    fontFamily: 'SF Pro',
    letterSpacing: -0.41,
    height: 1.25,
  );
}
