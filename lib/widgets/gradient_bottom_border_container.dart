import 'dart:math' as math;

import 'package:flutter/material.dart';

class GradientBottomBorderContainer extends StatelessWidget {
  static const LinearGradient defaultGradient = LinearGradient(
    colors: [
      Color.fromRGBO(115, 140, 150, 0.3),
      Color.fromRGBO(115, 140, 150, 0.0),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  final Widget child;
  final double borderWidth;
  final double borderRadius;
  final Gradient gradient;
  final double cutMargin;
  final Color backgroundColor;

  const GradientBottomBorderContainer({
    super.key,
    required this.child,
    this.borderWidth = 3.0,
    this.borderRadius = 12.0,
    this.cutMargin = 2.0,
    this.backgroundColor = Colors.transparent,
    this.gradient = defaultGradient,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _GradientBottomBorderPainter(
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        gradient: gradient,
        cutMargin: cutMargin,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: DecoratedBox(
          decoration: BoxDecoration(color: backgroundColor),
          child: child,
        ),
      ),
    );
  }
}

class _GradientBottomBorderPainter extends CustomPainter {
  final double borderWidth;
  final double borderRadius;
  final Gradient gradient;
  final double cutMargin;

  const _GradientBottomBorderPainter({
    required this.borderWidth,
    required this.borderRadius,
    required this.gradient,
    required this.cutMargin,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double r =
        math.min(borderRadius, math.min(size.width, size.height) / 2);

    final RRect outer =
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(r));

    canvas.save();
    canvas.clipRRect(outer);
    final double clipHeight = r + borderWidth;
    canvas.clipRect(
      Rect.fromLTWH(
        cutMargin.clamp(0.0, size.width / 2),
        size.height - clipHeight,
        (size.width - 2 * cutMargin).clamp(0.0, size.width),
        clipHeight,
      ),
    );

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..shader = gradient.createShader(
        Rect.fromLTWH(
          cutMargin.clamp(0.0, size.width / 2),
          size.height - clipHeight,
          (size.width - 2 * cutMargin).clamp(0.0, size.width),
          clipHeight,
        ),
      )
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.round;

    canvas.drawRRect(outer, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _GradientBottomBorderPainter oldDelegate) {
    return oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.gradient != gradient ||
        oldDelegate.cutMargin != cutMargin;
  }
}
