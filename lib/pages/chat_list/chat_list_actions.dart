import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:flutter/material.dart';

enum ChatListActions {
  editFolder,
  addChats,
  readAll,
  muteAll,
  ungroupFolder,
  ;

  String getTitle() {
    switch (this) {
      case ChatListActions.editFolder:
        return "Edit folder";
      case ChatListActions.addChats:
        return "Add chats";
      case ChatListActions.readAll:
        return "Read all";
      case ChatListActions.muteAll:
        return "Mute all";
      case ChatListActions.ungroupFolder:
        return "Ungroup folder";
    }
  }

  IconData getIcon() {
    switch (this) {
      case ChatListActions.editFolder:
        return Icons.edit_outlined;
      case ChatListActions.addChats:
        return Icons.add_circle_outline;
      case ChatListActions.readAll:
        return Icons.done_all;
      case ChatListActions.muteAll:
        return Icons.volume_off_outlined;
      case ChatListActions.ungroupFolder:
        return Icons.delete_outline;
    }
  }

  Color getColorIcon(BuildContext context) {
    switch (this) {
      case ChatListActions.editFolder:
      case ChatListActions.addChats:
      case ChatListActions.readAll:
      case ChatListActions.muteAll:
        return MultiColors.of(context).textMainPrimaryDefault;
      case ChatListActions.ungroupFolder:
        return MultiColors.of(context).textMainError;
    }
  }

  String? getImagePath() {
    switch (this) {
      case ChatListActions.editFolder:
        return ImagePaths.icEdit;
      case ChatListActions.muteAll:
        return ImagePaths.icMute;
      default:
        return null;
    }
  }
}
