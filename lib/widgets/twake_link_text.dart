import 'package:flutter/material.dart';
import 'package:matrix_link_text/link_text.dart';

class TwakeLinkText extends StatelessWidget {
  final String text;
  final Widget childWidget;
  final TextStyle? textStyle;
  final TextStyle? linkStyle;
  final TextAlign? textAlign;
  final LinkTapHandler? onLinkTap;
  final int? maxLines;

  const TwakeLinkText({
    Key? key,
    required this.text,
    required this.childWidget,
    this.textStyle,
    this.linkStyle,
    this.textAlign = TextAlign.start,
    this.onLinkTap,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CleanRichText(
      TextSpan(
        children: [
          LinkTextSpans(
            text: text,
            textStyle: textStyle,
            linkStyle: linkStyle,
            onLinkTap: onLinkTap,
            themeData: Theme.of(context),
          ),
          WidgetSpan(child: childWidget)
        ],
      ),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}