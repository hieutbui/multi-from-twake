import 'package:fluffychat/pages/chat/chat.dart';
import 'package:fluffychat/presentation/extensions/send_file_extension.dart';
import 'package:fluffychat/utils/string_extension.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_matrix_html/text_parser.dart';
import 'package:matrix/matrix.dart';

class Pill extends StatelessWidget {
  final String identifier;
  final String url;
  final OnPillTap? onTap;
  final ChatController chatController;

  const Pill({
    Key? key,
    required this.identifier,
    required this.chatController,
    required this.url,
    this.onTap,
  }) : super(key: key);

  static const int maxCharactersDisplayNameForPill = 28;

  @override
  Widget build(BuildContext context) {
    final user = chatController.room?.getUser(identifier);
    final displayName = user?.displayName ?? identifier;
    final avatarUrl =
        user?.avatarUrl?.getDownloadLink(Matrix.of(context).client);
    final avatarSize = DefaultTextStyle.of(context).style.fontSize ?? 14.0;
    final padding = avatarSize / 20;
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(
          top: padding,
          bottom: padding,
          left: avatarUrl != null ? padding * 3 : avatarSize / 2,
          right: avatarSize / 2,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.all(Radius.circular(avatarSize + padding)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (avatarUrl?.toString().isNotEmpty == true)
              CircleAvatar(
                radius: avatarSize / 2,
                backgroundImage:
                    CachedNetworkImageProvider(avatarUrl!.toString()),
              ),
            Flexible(
              child: Text(
                displayName.shortenDisplayName(
                  maxCharacters: maxCharactersDisplayNameForPill,
                ),
                style: const TextStyle(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        onTap?.call(url);
      },
    );
  }
}
