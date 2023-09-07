import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluffychat/pages/chat/chat_app_bar_title_style.dart';
import 'package:fluffychat/utils/room_status_extension.dart';
import 'package:fluffychat/utils/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:matrix/matrix.dart';
import 'package:fluffychat/pages/user_bottom_sheet/user_bottom_sheet.dart';
import 'package:fluffychat/utils/adaptive_bottom_sheet.dart';
import 'package:fluffychat/utils/matrix_sdk_extensions/matrix_locals.dart';
import 'package:fluffychat/widgets/avatar/avatar.dart';

class ChatAppBarTitle extends StatelessWidget {
  final Widget? actions;
  final Room? room;
  final List<Event> selectedEvents;
  final bool isArchived;
  final TextEditingController sendController;
  final Stream<ConnectivityResult> getStreamInstance;

  const ChatAppBarTitle({
    Key? key,
    required this.actions,
    this.room,
    required this.selectedEvents,
    required this.isArchived,
    required this.sendController,
    required this.getStreamInstance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (room == null) {
      return Container();
    }
    if (selectedEvents.isNotEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(selectedEvents.length.toString()),
          actions ?? const SizedBox.shrink(),
        ],
      );
    }
    final directChatMatrixID = room?.directChatMatrixID;
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: directChatMatrixID != null
          ? () => showAdaptiveBottomSheet(
                context: context,
                builder: (c) => UserBottomSheet(
                  user: room!
                      .unsafeGetUserFromMemoryOrFallback(directChatMatrixID),
                  outerContext: context,
                  onMention: () => sendController.text +=
                      '${room!.unsafeGetUserFromMemoryOrFallback(directChatMatrixID).mention} ',
                ),
              )
          : isArchived
              ? null
              : () => context.go('/rooms/${room!.id}/details'),
      child: Row(
        children: [
          Stack(
            children: [
              Hero(
                tag: 'content_banner',
                child: Avatar(
                  fontSize: ChatAppBarTitleStyle.avatarFontSize,
                  mxContent: room!.avatar,
                  name: room!.getLocalizedDisplayname(
                    MatrixLocals(L10n.of(context)!),
                  ),
                  size: ChatAppBarTitleStyle.avatarSize(context),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room!.getLocalizedDisplayname(
                    MatrixLocals(L10n.of(context)!),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: ChatAppBarTitleStyle.appBarTitleStyle(context),
                ),
                _buildStatusContent(context, room!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder<ConnectivityResult> _buildStatusContent(
    BuildContext context,
    Room room,
  ) {
    final TextStyle? statusTextStyle =
        ChatAppBarTitleStyle.statusTextStyle(context);

    return StreamBuilder<ConnectivityResult>(
      stream: getStreamInstance,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == ConnectivityResult.none) {
          return Text(
            L10n.of(context)!.noConnection,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: statusTextStyle,
          );
        }
        final typingText = room.getLocalizedTypingText(context);
        if (typingText.isEmpty) {
          return Text(
            room.getLocalizedStatus(context).capitalize(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: statusTextStyle,
          );
        } else {
          return IntrinsicWidth(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    typingText,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: statusTextStyle,
                  ),
                ),
                SizedBox(
                  width: 32,
                  height: 16,
                  child: Transform.translate(
                    offset: const Offset(0, -2),
                    child: LottieBuilder.asset(
                      'assets/typing-indicator.zip',
                      fit: BoxFit.fitWidth,
                      width: 32,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
