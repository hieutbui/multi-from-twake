import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/pages/chat/chat_actions_style.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_sys_colors.dart';

enum PickerType {
  gallery,
  documents,
  location,
  contact;

  String getTitle(BuildContext context) {
    switch (this) {
      case PickerType.gallery:
        return L10n.of(context)!.gallery;
      case PickerType.documents:
        return L10n.of(context)!.documents;
      case PickerType.location:
        return L10n.of(context)!.location;
      case PickerType.contact:
        return L10n.of(context)!.contact;
    }
  }

  IconData getIcon() {
    switch (this) {
      case PickerType.gallery:
        return Icons.photo_outlined;
      case PickerType.documents:
        return Icons.attach_file;
      case PickerType.location:
        return Icons.my_location;
      case PickerType.contact:
        return Icons.person;
    }
  }

  Color getIconColor() {
    switch (this) {
      case PickerType.gallery:
        return ChatActionsStyle.colorGalleryIcon;
      case PickerType.documents:
        return ChatActionsStyle.colorDocumentIcon;
      case PickerType.location:
        return ChatActionsStyle.colorLocationIcon;
      case PickerType.contact:
        return ChatActionsStyle.colorContactIcon;
    }
  }

  Color getBackgroundColor() {
    switch (this) {
      case PickerType.gallery:
      case PickerType.documents:
        return ChatActionsStyle.colorBackgroundGalleryBottom;
      case PickerType.location:
        return ChatActionsStyle.colorBackgroundLocationBottom;
      case PickerType.contact:
        return ChatActionsStyle.colorBackgroundContactBottom;
    }
  }

  Color? getTextColor(BuildContext context) {
    switch (this) {
      case PickerType.gallery:
        return MultiSysColors.material().primary;
      case PickerType.documents:
        return MultiSysColors.material().tertiary;
      case PickerType.location:
      case PickerType.contact:
        return MultiSysColors.material().onBackground;
    }
  }
}

enum ChatScrollState {
  scrolling,
  startScroll,
  endScroll;

  bool get isScrolling => this == ChatScrollState.scrolling;

  bool get isStartScroll => this == ChatScrollState.startScroll;

  bool get isEndScroll => this == ChatScrollState.endScroll;
}

enum ChatAppBarActions {
  info,
  report,
  saveToDownload,
  saveToGallery,
  viewContact,
  editContact,
  search,
  muteChat,
  muteContact,
  muteGroup,
  unmuteChat,
  unmuteContact,
  unmuteGroup,
  favorites,
  makeGroup,
  addToFolder,
  deleteContact,
  deleteGroup;

  String getTitle(BuildContext context) {
    switch (this) {
      case ChatAppBarActions.info:
        return L10n.of(context)!.messageInfo;
      case ChatAppBarActions.report:
        return L10n.of(context)!.reportMessage;
      case ChatAppBarActions.saveToDownload:
        return L10n.of(context)!.saveToDownloads;
      case ChatAppBarActions.saveToGallery:
        return L10n.of(context)!.saveToGallery;
      case ChatAppBarActions.viewContact:
        return "View contact";
      case ChatAppBarActions.editContact:
        return "Edit contact";
      case ChatAppBarActions.search:
        return "Search";
      case ChatAppBarActions.muteChat:
        return "Mute chat";
      case ChatAppBarActions.muteContact:
        return "Mute contact";
      case ChatAppBarActions.muteGroup:
        return "Mute group";
      case ChatAppBarActions.unmuteChat:
        return "Unmute chat";
      case ChatAppBarActions.unmuteContact:
        return "Unmute contact";
      case ChatAppBarActions.unmuteGroup:
        return "Unmute group";
      case ChatAppBarActions.favorites:
        return "Favorites";
      case ChatAppBarActions.makeGroup:
        return "Make group";
      case ChatAppBarActions.addToFolder:
        return "Add to folder";
      case ChatAppBarActions.deleteContact:
        return "Delete contact";
      case ChatAppBarActions.deleteGroup:
        return "Delete group";
    }
  }

  IconData getIcon() {
    switch (this) {
      case ChatAppBarActions.info:
        return Icons.info_outlined;
      case ChatAppBarActions.report:
        return Icons.shield_outlined;
      case ChatAppBarActions.saveToDownload:
        return Icons.download_outlined;
      case ChatAppBarActions.saveToGallery:
        return Icons.save_outlined;
      case ChatAppBarActions.viewContact:
        return Icons.edit;
      case ChatAppBarActions.editContact:
        return Icons.edit_outlined;
      case ChatAppBarActions.search:
        return Icons.search_outlined;
      case ChatAppBarActions.muteChat:
        return Icons.volume_off_outlined;
      case ChatAppBarActions.muteContact:
        return Icons.volume_off_outlined;
      case ChatAppBarActions.muteGroup:
        return Icons.volume_off_outlined;
      case ChatAppBarActions.unmuteChat:
        return Icons.volume_up_outlined;
      case ChatAppBarActions.unmuteContact:
        return Icons.volume_up_outlined;
      case ChatAppBarActions.unmuteGroup:
        return Icons.volume_up_outlined;
      case ChatAppBarActions.favorites:
        return Icons.favorite_border_outlined;
      case ChatAppBarActions.makeGroup:
        return Icons.group_outlined;
      case ChatAppBarActions.addToFolder:
        return Icons.folder_outlined;
      case ChatAppBarActions.deleteContact:
        return Icons.delete_outline;
      case ChatAppBarActions.deleteGroup:
        return Icons.delete_outline;
    }
  }

  Color getColorIcon(BuildContext context) {
    switch (this) {
      case ChatAppBarActions.info:
      case ChatAppBarActions.saveToDownload:
      case ChatAppBarActions.saveToGallery:
        return Theme.of(context).colorScheme.onSurface;
      case ChatAppBarActions.report:
        return MultiSysColors.material().errorDark;
      case ChatAppBarActions.deleteContact:
      case ChatAppBarActions.deleteGroup:
        return MultiColors.of(context).textMainError;
      case ChatAppBarActions.viewContact:
      case ChatAppBarActions.editContact:
      case ChatAppBarActions.search:
      case ChatAppBarActions.muteChat:
      case ChatAppBarActions.muteContact:
      case ChatAppBarActions.muteGroup:
      case ChatAppBarActions.unmuteChat:
      case ChatAppBarActions.unmuteContact:
      case ChatAppBarActions.unmuteGroup:
      case ChatAppBarActions.favorites:
      case ChatAppBarActions.makeGroup:
      case ChatAppBarActions.addToFolder:
        return MultiColors.of(context).textMainPrimaryDefault;
    }
  }

  String? getImagePath() {
    switch (this) {
      case ChatAppBarActions.viewContact:
        return ImagePaths.icEdit;
      case ChatAppBarActions.editContact:
        return ImagePaths.icEdit;
      case ChatAppBarActions.muteChat:
      case ChatAppBarActions.muteContact:
      case ChatAppBarActions.muteGroup:
        return ImagePaths.icMute;
      default:
        return null;
    }
  }

  EdgeInsets getPaddingTitle() {
    return const EdgeInsets.only(left: 20);
  }
}
