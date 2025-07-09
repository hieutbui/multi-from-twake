import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_sys_colors.dart';
import 'package:flutter/material.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';

class MessageTimeStyle {
  static Color? timelineColor(
    bool timelineOverlayMessage,
    BuildContext context,
  ) =>
      timelineOverlayMessage
          ? Theme.of(context).brightness == Brightness.light
              ? MultiLightColors.textMainTertiaryDisabled
              : MultiDarkColors.textMainTertiaryDisabled
          : LinagoraRefColors.material().neutral[50];

  static double get timelineLetterSpacing => 0.4;

  static double get paddingTimeAndIcon => 2.0;
  static double get seenByRowIconSize => 14;
  static Color seenByRowIconPrimaryColor(
    bool timelineOverlayMessage,
    BuildContext context,
  ) =>
      timelineOverlayMessage
          ? Colors.white
          : MultiSysColors.material().secondary;
  static Color? seenByRowIconSecondaryColor(
    bool timelineOverlayMessage,
    BuildContext context,
  ) =>
      timelineOverlayMessage
          ? Theme.of(context).colorScheme.onPrimary
          : LinagoraRefColors.material().neutral[50];

  static TextStyle? textStyle(
    BuildContext context,
    bool timelineOverlayMessage,
  ) =>
      Theme.of(context).textTheme.bodySmall?.merge(
            TextStyle(
              color: timelineColor(timelineOverlayMessage, context),
              letterSpacing: 0.4,
            ),
          );
}
