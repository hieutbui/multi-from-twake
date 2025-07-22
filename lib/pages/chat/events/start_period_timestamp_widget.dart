import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:flutter/material.dart';

class StartPeriodTimestampWidget extends StatelessWidget {
  final String content;

  const StartPeriodTimestampWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 14.0,
      ),
      alignment: Alignment.topCenter,
      child: UnconstrainedBox(
        child: Opacity(
          opacity: 1.0,
          child: Container(
            margin: const EdgeInsets.only(top: 8.0),
            decoration: ShapeDecoration(
              color: MultiColors.of(context).backgroundSurfacesTransparent,
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Color(0x4C738C96),
                ),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 2.0,
              ),
              child: Column(
                children: [
                  Text(
                    content,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
