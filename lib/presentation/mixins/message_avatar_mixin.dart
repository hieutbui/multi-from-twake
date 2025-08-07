import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/pages/chat/events/message/message_style.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:fluffychat/widgets/avatar/avatar.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

mixin MessageAvatarMixin {
  ResponsiveUtils responsive = getIt.get<ResponsiveUtils>();

  bool _shouldDisplayAvatar(
    bool sameSender,
    bool ownMessage,
    BuildContext context,
  ) {
    return sameSender && !(ownMessage && responsive.isMobile(context));
  }

  bool _shouldDisplayAvatarForOwnMessage(
    bool sameSender,
    bool ownMessage,
    BuildContext context,
  ) {
    return sameSender && ownMessage && responsive.isMobile(context);
  }

  Widget placeHolderWidget(
    Function(Event)? onAvatarTap, {
    required bool sameSender,
    required bool ownMessage,
    required Event event,
    required BuildContext context,
    required bool selectMode,
  }) {
    if (selectMode ||
        (event.room.isDirectChat && responsive.isMobile(context))) {
      return const SizedBox();
    }

    if (_shouldDisplayAvatar(sameSender, ownMessage, context)) {
      return Padding(
        padding: MessageStyle.paddingAvatar,
        child: FutureBuilder<User?>(
          future: event.fetchSenderUser(),
          builder: (context, snapshot) {
            final user = snapshot.data ?? event.senderFromMemoryOrFallback;
            return Avatar(
              size: MessageStyle.avatarSize,
              fontSize: MessageStyle.fontSize,
              mxContent: user.avatarUrl,
              name: user.calcDisplayname(),
              onTap: () => onAvatarTap!(event),
            );
          },
        ),
      );
    }

    return const Padding(
      padding: MessageStyle.paddingAvatar,
      child: SizedBox(width: MessageStyle.avatarSize),
    );
  }

  Widget placeHolderWidgetForOwnMessage(
    Function(Event)? onAvatarTap, {
    required bool sameSender,
    required bool ownMessage,
    required Event event,
    required BuildContext context,
    required bool selectMode,
  }) {
    if (selectMode ||
        (event.room.isDirectChat && responsive.isMobile(context))) {
      return const SizedBox();
    }

    if (_shouldDisplayAvatarForOwnMessage(sameSender, ownMessage, context)) {
      return Padding(
        padding: MessageStyle.paddingAvatarForOwnMessage,
        child: FutureBuilder<User?>(
          future: event.fetchSenderUser(),
          builder: (context, snapshot) {
            final user = snapshot.data ?? event.senderFromMemoryOrFallback;
            return Avatar(
              size: MessageStyle.avatarSize,
              fontSize: MessageStyle.fontSize,
              mxContent: user.avatarUrl,
              name: user.calcDisplayname(),
              onTap: () => onAvatarTap!(event),
            );
          },
        ),
      );
    }

    return const Padding(
      padding: MessageStyle.paddingAvatarForOwnMessage,
      child: SizedBox(width: MessageStyle.avatarSize),
    );
  }
}
