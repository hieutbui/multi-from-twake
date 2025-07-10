import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:flutter/material.dart';

class ReplyContentStyle {
  static ResponsiveUtils responsive = getIt.get<ResponsiveUtils>();
  // static const double fontSizeDisplayName = AppConfig.messageFontSize * 0.76;
  // static const double fontSizeDisplayContent = AppConfig.messageFontSize * 0.88;
  static const double fontSizeDisplayName = 11;
  static const double fontSizeDisplayContent = 16;
  static const double replyContentSize = fontSizeDisplayContent * 2;

  static const EdgeInsets replyParentContainerPadding = EdgeInsets.only(
    left: 4,
    right: 8.0,
    top: 8.0,
    bottom: 8.0,
  );

  static BoxDecoration replyParentContainerDecoration(
    BuildContext context,
    bool ownMessage,
  ) {
    final receiverColor = Theme.of(context).brightness == Brightness.light
        ? MultiLightColors.messagesReceiverHover
        : MultiDarkColors.messagesReceiverHover;

    final senderColor = Theme.of(context).brightness == Brightness.light
        ? MultiLightColors.messagesSenderHover
        : MultiDarkColors.messagesSenderHover;

    return BoxDecoration(
      color: ownMessage ? receiverColor : senderColor,
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      border: Border(
        left: BorderSide(
          color: ownMessage ? Colors.black : const Color(0xFF76a4ee),
          width: 2,
        ),
      ),
    );
  }

  static const double prefixBarWidth = 3.0;
  static const double prefixBarVerticalPadding = 4.0;
  static BoxDecoration prefixBarDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(2),
      color: Theme.of(context).colorScheme.primary,
    );
  }

  static const double contentSpacing = 6.0;
  static const BorderRadius previewedImageBorderRadius =
      BorderRadius.all(Radius.circular(4));
  static const double previewedImagePlaceholderPadding = 4.0;

  static TextStyle? displayNameTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      fontWeight: FontWeight.w600,
      fontSize: fontSizeDisplayName,
      height: 1.18,
      letterSpacing: 0.06,
      fontFamily: MultiFonts.sfPro,
    );
  }

  static TextStyle? replyBodyTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: fontSizeDisplayContent,
          overflow: TextOverflow.ellipsis,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        );
  }

  static EdgeInsetsDirectional get marginReplyContent =>
      EdgeInsetsDirectional.symmetric(
        horizontal: 8,
        vertical: 4.0 * AppConfig.bubbleSizeFactor,
      );

  static const double replyContainerHeight = 60;
}
