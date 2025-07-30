import 'dart:async';

import 'package:dartz/dartz.dart' hide State;
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/contact/lookup_match_contact_state.dart';
import 'package:fluffychat/domain/model/room/room_extension.dart';
import 'package:fluffychat/domain/usecase/contacts/lookup_match_contact_interactor.dart';
import 'package:fluffychat/pages/chat/chat_actions.dart';
import 'package:fluffychat/pages/chat_details/chat_details_page_view/chat_details_page_enum.dart';
import 'package:fluffychat/pages/chat_profile_info/chat_profile_info_view.dart';
import 'package:fluffychat/pages/chat_profile_info/widgets/info_tab_view.dart';
import 'package:fluffychat/presentation/enum/chat/chat_details_screen_enum.dart';
import 'package:fluffychat/presentation/mixins/chat_details_tab_mixin.dart';
import 'package:fluffychat/presentation/mixins/handle_video_download_mixin.dart';
import 'package:fluffychat/presentation/mixins/leave_chat_mixin.dart';
import 'package:fluffychat/presentation/mixins/mute_chat_mixin.dart';
import 'package:fluffychat/presentation/mixins/play_video_action_mixin.dart';
import 'package:fluffychat/presentation/model/contact/presentation_contact.dart';
import 'package:fluffychat/widgets/context_menu/context_menu_action.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:fluffychat/widgets/mixins/popup_menu_widget_style.dart';
import 'package:fluffychat/widgets/mixins/twake_context_menu_mixin.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class ChatProfileInfo extends StatefulWidget {
  final VoidCallback? onBack;
  final String? roomId;
  final PresentationContact? contact;
  final bool isInStack;
  final bool isDraftInfo;

  const ChatProfileInfo({
    super.key,
    required this.onBack,
    required this.isInStack,
    this.roomId,
    this.contact,
    required this.isDraftInfo,
  });

  @override
  State<ChatProfileInfo> createState() => ChatProfileInfoController();
}

class ChatProfileInfoController extends State<ChatProfileInfo>
    with
        HandleVideoDownloadMixin,
        PlayVideoActionMixin,
        SingleTickerProviderStateMixin,
        TwakeContextMenuMixin,
        LeaveChatMixin,
        MuteChatMixin,
        ChatDetailsTabMixin<ChatProfileInfo> {
  final _lookupMatchContactInteractor =
      getIt.get<LookupMatchContactInteractor>();

  StreamSubscription? lookupContactNotifierSub;

  final ValueNotifier<Either<Failure, Success>> lookupContactNotifier =
      ValueNotifier<Either<Failure, Success>>(
    const Right(LookupContactsInitial()),
  );

  @override
  Room? get room => widget.roomId != null
      ? Matrix.of(context).client.getRoomById(widget.roomId!)
      : null;

  @override
  ChatDetailsScreenEnum get chatType => ChatDetailsScreenEnum.direct;

  User? get user =>
      room?.unsafeGetUserFromMemoryOrFallback(room?.directChatMatrixID ?? '');

  void lookupMatchContactAction() {
    lookupContactNotifierSub = _lookupMatchContactInteractor
        .execute(
          val: widget.contact?.matrixId ?? user?.id ?? '',
        )
        .listen(
          (event) => lookupContactNotifier.value = event,
        );
  }

  ScrollPhysics getScrollPhysics() {
    if (tabList.isEmpty) {
      return const NeverScrollableScrollPhysics();
    } else {
      return const ClampingScrollPhysics();
    }
  }

  void onPressBack() {
    Navigator.of(context).pop();
  }

  List<Widget> getTabBarViewList() {
    return sharedPages().asMap().entries.map((page) {
      final index = page.key;
      final value = page.value;
      if (index == ChatDetailsPage.info.index) {
        return const InfoTabView();
      }
      return value.child;
    }).toList();
  }

  void handleAppbarMenuAction(
    BuildContext context,
    TapDownDetails tapDownDetails,
  ) async {
    final offset = tapDownDetails.globalPosition;
    final selectedActionIndex = await showTwakeContextMenu(
      offset: offset,
      context: context,
      listActions: getListActions()
          .map(
            (action) => ContextMenuAction(
              name: action.getTitle(context),
              icon: action.getIcon(),
              colorIcon: action.getColorIcon(context),
              styleName:
                  PopupMenuWidgetStyle.defaultItemTextStyle(context)?.copyWith(
                color: action.getColorIcon(context),
              ),
              imagePath: action.getImagePath(),
            ),
          )
          .toList(),
    );

    if (selectedActionIndex != null && selectedActionIndex is int) {
      final selectedAction = getListActions()[selectedActionIndex];
      onSelectedAppBarActions(selectedAction);
    }
  }

  List<ChatAppBarActions> getListActions() {
    return [
      ChatAppBarActions.editContact,
      if (room != null) ...[
        if (room!.isMuted)
          ChatAppBarActions.unmuteContact
        else
          ChatAppBarActions.muteContact,
      ],
      ChatAppBarActions.deleteContact,
    ];
  }

  void onSelectedAppBarActions(ChatAppBarActions action) {
    switch (action) {
      case ChatAppBarActions.editContact:
        break;
      case ChatAppBarActions.unmuteContact:
      case ChatAppBarActions.muteContact:
        muteChat(context, room);
        break;
      case ChatAppBarActions.deleteContact:
        leaveChat(context, room);
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    lookupMatchContactAction();
  }

  @override
  void dispose() {
    super.dispose();
    lookupContactNotifier.dispose();
    lookupContactNotifierSub?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ChatProfileInfoView(this);
  }
}
