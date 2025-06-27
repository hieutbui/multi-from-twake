import 'package:fluffychat/config/multi_sys_variables/multi_sys_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

enum ProfileInfoActions {
  sendMessage,
  removeFromGroup;

  String label(BuildContext context) {
    switch (this) {
      case ProfileInfoActions.sendMessage:
        return L10n.of(context)!.sendMessage;
      case ProfileInfoActions.removeFromGroup:
        return L10n.of(context)!.removeFromGroup;
    }
  }

  TextStyle textStyle(BuildContext context) {
    switch (this) {
      case ProfileInfoActions.sendMessage:
        return Theme.of(context).textTheme.titleMedium!.copyWith(
              color: MultiSysColors.material().primary,
            );
      case ProfileInfoActions.removeFromGroup:
        return Theme.of(context).textTheme.titleMedium!.copyWith(
              color: MultiSysColors.material().error,
            );
    }
  }

  Icon icon() {
    switch (this) {
      case ProfileInfoActions.sendMessage:
        return const Icon(Icons.chat_outlined);
      case ProfileInfoActions.removeFromGroup:
        return Icon(
          Icons.logout_outlined,
          color: MultiSysColors.material().error,
        );
    }
  }
}
