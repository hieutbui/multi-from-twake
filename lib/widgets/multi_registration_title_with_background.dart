import 'package:fluffychat/resource/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MultiRegistrationTitleWithBackground extends StatelessWidget {
  final String title;

  const MultiRegistrationTitleWithBackground({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const double leftMargin = 20.0;
    final double textWidth = screenWidth - leftMargin * 2;
    final double containerHeight =
        _calculateContainerHeight(context, textWidth);

    return SizedBox(
      height: containerHeight,
      width: textWidth,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(ImagePaths.imgMultiBlur),
          ),
          Positioned(
            top: 28,
            left: 0,
            child: SizedBox(
              width: textWidth,
              child: Text(
                title,
                maxLines: null,
                softWrap: true,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white.withAlpha(222),
                      fontSize: 34,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.white.withAlpha(222),
              fontSize: 34,
            ) ??
        const TextStyle(fontSize: 34);
  }

  double _calculateContainerHeight(BuildContext context, double textWidth) {
    const double svgHeight = 70.0;
    const double textTopAdjustment = 28.0;

    final textStyle = _getTextStyle(context);
    final textSpan = TextSpan(text: title, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: null,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: textWidth);
    final int lineCount = textPainter.computeLineMetrics().length;
    final double textHeight = textPainter.height;
    return lineCount == 1 ? svgHeight : textHeight + textTopAdjustment;
  }
}
