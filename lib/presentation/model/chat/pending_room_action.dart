import 'package:flutter/material.dart';

enum PendingRoomAction {
  accept,
  block,
  report;

  //TODO: Update to l10n when implementing multi language
  String getTitle(BuildContext context) {
    switch (this) {
      case PendingRoomAction.accept:
        return 'Accept';
      case PendingRoomAction.block:
        return 'Block';
      case PendingRoomAction.report:
        return 'Report';
    }
  }
}
