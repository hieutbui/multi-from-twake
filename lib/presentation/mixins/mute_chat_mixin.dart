import 'package:fluffychat/domain/model/room/room_extension.dart';
import 'package:fluffychat/utils/dialog/twake_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:matrix/matrix.dart';

mixin MuteChatMixin {
  Future<void> muteChat(BuildContext context, Room? room) async {
    if (room == null) return;
    TwakeDialog.showFutureLoadingDialogFullScreen(
      future: () async {
        if (room.isMuted) {
          await room.unmute();
        } else {
          await room.mute();
        }
      },
    );
  }
}
