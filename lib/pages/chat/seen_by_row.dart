import 'package:fluffychat/pages/chat/events/message_time_style.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix/matrix.dart';

enum MessageStatus {
  sending,
  sent,
  hasBeenSeen,
  error,
}

class SeenByRow extends StatelessWidget {
  final List<User> getSeenByUsers;
  final List<User> participants;
  final EventStatus? eventStatus;
  final bool timelineOverlayMessage;
  final Event event;

  const SeenByRow({
    this.eventStatus,
    super.key,
    required this.getSeenByUsers,
    required this.participants,
    required this.timelineOverlayMessage,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return getEventIcon(
      context,
      getSeenByUsers,
      eventStatus: eventStatus,
    );
  }

  MessageStatus getMessageStatus(
    BuildContext context,
    List<User> seenByUsers, {
    EventStatus? eventStatus,
  }) {
    if (eventStatus == null || eventStatus == EventStatus.sending) {
      return MessageStatus.sending;
    }

    if (eventStatus == EventStatus.sent || seenByUsers.isEmpty) {
      return MessageStatus.sent;
    }

    if (eventStatus == EventStatus.error) {
      return MessageStatus.error;
    }

    return MessageStatus.hasBeenSeen;
  }

  Widget getEventIcon(
    BuildContext context,
    List<User> seenByUsers, {
    bool? oldMessageFullyRead,
    EventStatus? eventStatus,
  }) {
    final messageStatus = getMessageStatus(
      context,
      seenByUsers,
      eventStatus: eventStatus,
    );
    switch (messageStatus) {
      case MessageStatus.sending:
        return Icon(
          Icons.schedule,
          color: MessageTimeStyle.seenByRowIconSecondaryColor(
            timelineOverlayMessage,
            context,
          ),
          size: MessageTimeStyle.seenByRowIconSize,
        );
      case MessageStatus.sent:
        return SvgPicture.asset(
          ImagePaths.icCheck,
          width: MessageTimeStyle.seenByRowIconSize,
        );
      case MessageStatus.hasBeenSeen:
        return SvgPicture.asset(
          ImagePaths.icDoubleCheck,
          width: MessageTimeStyle.seenByRowIconSize,
        );
      case MessageStatus.error:
        return Text(
          'Delivery failed',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
        );
    }
  }
}
