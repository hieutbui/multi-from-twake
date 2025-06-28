import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:flutter/material.dart';

const Duration _snackBarDefaultDisplayDuration = Duration(milliseconds: 4000);

class TwakeSnackBarStyle {
  static ResponsiveUtils responsiveUtils = getIt.get<ResponsiveUtils>();

  static const EdgeInsetsDirectional snackBarPadding =
      EdgeInsetsDirectional.symmetric(
    horizontal: 16,
    vertical: 14,
  );

  static double? widthSnackBar(BuildContext context) {
    if (responsiveUtils.isWebDesktop(context)) {
      return 334;
    } else {
      return null;
    }
  }
}

class TwakeSnackBar {
  static void show(
    BuildContext context,
    String message, {
    Duration duration = _snackBarDefaultDisplayDuration,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: TwakeSnackBarStyle.widthSnackBar(context),
        padding: TwakeSnackBarStyle.snackBarPadding,
        duration: duration,
        content: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      // TODO: change to colorSurface when its approved
                      // ignore: deprecated_member_use
                      color: isError == false
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.error,
                    ),
              ),
            ),
            InkWell(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Icon(
                Icons.close,
                color: isError == false
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
