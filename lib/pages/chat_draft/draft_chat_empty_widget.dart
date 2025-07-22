import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/pages/chat/chat_app_bar_title_style.dart';
import 'package:fluffychat/pages/chat_draft/draft_chat_empty_widget_style.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/widgets/avatar/avatar.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix/matrix.dart';

class DraftChatEmpty extends StatelessWidget {
  final String receiverId;
  final String? displayName;
  final void Function()? onTap;

  const DraftChatEmpty({
    super.key,
    required this.receiverId,
    this.displayName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: DraftChatEmptyWidgetStyle.greetingButtonBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                _HelloAvatar(
                  receiverId: receiverId,
                  displayName: displayName,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: MultiColors.of(context).additionalAccentBlueMain,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        ImagePaths.icHandHello,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Just a friendly reminder to keep it cool and respectful in personal chats and groups',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _HelloAvatar extends StatelessWidget {
  final String receiverId;
  final String? displayName;

  const _HelloAvatar({
    required this.receiverId,
    this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getReceiverProfile(context, receiverId),
      builder: (context, snapshot) {
        return Hero(
          tag: 'draft_chat_avatar',
          child: Avatar(
            fontSize: ChatAppBarTitleStyle.avatarFontSize,
            mxContent: snapshot.data?.avatarUrl,
            name: snapshot.data?.displayName ?? displayName ?? receiverId,
            size: 60,
          ),
        );
      },
    );
  }

  Future<Profile> _getReceiverProfile(
    BuildContext context,
    String receiverId,
  ) async {
    try {
      return await Matrix.of(context)
          .client
          .getProfileFromUserId(receiverId, getFromRooms: false);
    } catch (e) {
      return Profile(
        avatarUrl: null,
        displayName: null,
        userId: receiverId,
      );
    }
  }
}
