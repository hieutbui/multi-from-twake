import 'package:flutter/material.dart';

class MultiCustomBorderInput extends UnderlineInputBorder {
  final BoxShadow? shadow;

  const MultiCustomBorderInput({
    super.borderRadius,
    super.borderSide,
    this.shadow,
  });

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final RRect outer = borderRadius.toRRect(rect);
    final RRect center = outer.deflate(borderSide.width / 2.0);

    // Draw shadow if provided
    if (shadow != null) {
      final Paint shadowPaint = Paint()
        ..color = shadow!.color
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          shadow!.blurRadius,
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderSide.width + shadow!.spreadRadius * 2;

      // Draw shadow only for the border path, not filling the entire area
      canvas.drawRRect(center, shadowPaint);
    }

    // Draw the border
    final Paint paint = borderSide.toPaint();
    canvas.drawRRect(center, paint);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is MultiCustomBorderInput) {
      return MultiCustomBorderInput(
        borderRadius: BorderRadius.lerp(borderRadius, b.borderRadius, t)!,
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        shadow: BoxShadow.lerp(shadow, b.shadow, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    return lerpTo(a, 1 - t);
  }
}
