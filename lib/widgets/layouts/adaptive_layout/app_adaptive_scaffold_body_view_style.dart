import 'package:flutter/cupertino.dart';

class AppAdaptiveScaffoldBodyViewStyle {
  static const EdgeInsetsGeometry navBarBackLayoutPadding = EdgeInsets.only(
    top: 10.0,
    bottom: 19.0,
    left: 16.0,
    right: 16.0,
  );

  static const Decoration navBarDecoration = BoxDecoration(
    color: Color(0xFF212227),
    borderRadius: BorderRadius.all(Radius.circular(24)),
    boxShadow: [
      BoxShadow(
        color: Color(0x14202126),
        blurRadius: 25,
        offset: Offset(0, -16),
        spreadRadius: 0,
      ),
    ],
  );
}
