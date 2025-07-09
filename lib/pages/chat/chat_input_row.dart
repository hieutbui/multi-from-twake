import 'package:fluffychat/pages/chat/chat_input_row_mobile.dart';
import 'package:fluffychat/pages/chat/chat_input_row_style.dart';
import 'package:fluffychat/pages/chat/chat_input_row_web.dart';
import 'package:fluffychat/pages/chat/reply_display.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:fluffychat/widgets/avatar/avatar.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix/matrix.dart';

import 'chat.dart';
import 'input_bar/input_bar.dart';

class ChatInputRow extends StatelessWidget {
  final ChatController controller;

  const ChatInputRow(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Padding(
          padding: EdgeInsets.zero,
          child: Row(
            crossAxisAlignment:
                ChatInputRowStyle.responsiveUtils.isMobile(context)
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: controller.selectMode
                ? [
                    ActionSelectModeWidget(
                      controller: controller,
                    ),
                  ]
                : <Widget>[
                    // if (ChatInputRowStyle.responsiveUtils.isMobile(context))
                    //   SizedBox(
                    //     height: ChatInputRowStyle.chatInputRowHeight,
                    //     child: TwakeIconButton(
                    //       size: ChatInputRowStyle.chatInputRowMoreBtnSize,
                    //       tooltip: L10n.of(context)!.more,
                    //       icon: Icons.add_circle_outline,
                    //       onTap: () => controller.onSendFileClick(context),
                    //     ),
                    //   ),
                    // if (controller.matrix!.isMultiAccount &&
                    //     controller.matrix!.hasComplexBundles &&
                    //     controller.matrix!.currentBundle!.length > 1)
                    //   Container(
                    //     height: ChatInputRowStyle.chatInputRowHeight,
                    //     alignment: Alignment.center,
                    //     child: ChatAccountPicker(controller),
                    //   ),
                    Expanded(
                      child: ChatInputRowStyle.responsiveUtils.isMobile(context)
                          ? _buildMobileInputRow(context)
                          : _buildWebInputRow(context),
                    ),
                    // ChatInputRowSendBtn(
                    //   inputText: controller.inputText,
                    //   onTap: controller.onInputBarSubmitted,
                    // ),
                  ],
          ),
        );
      },
    );
  }

  ChatInputRowMobile _buildMobileInputRow(BuildContext context) {
    return ChatInputRowMobile(
      inputBar: ValueListenableBuilder(
        valueListenable: controller.showEmojiPickerNotifier,
        builder: (context, value, _) {
          return Column(
            children: [
              ReplyDisplay(controller),
              Offstage(
                offstage: value,
                child: _buildInputBar(context),
              ),
            ],
          );
        },
      ),
    );
  }

  ChatInputRowWeb _buildWebInputRow(BuildContext context) {
    return ChatInputRowWeb(
      editEventNotifier: controller.editEventNotifier,
      onCloseEditAction: controller.cancelEditEventAction,
      inputBar: Column(
        children: [
          ReplyDisplay(controller),
          _buildInputBar(context),
        ],
      ),
      onTapMoreBtn: () => controller.onSendFileClick(context),
      onEmojiAction: controller.onEmojiAction,
    );
  }

  Widget _buildInputBar(BuildContext context) {
    return InputBar(
      typeAheadKey: controller.chatComposerTypeAheadKey,
      rawKeyboardFocusNode: controller.rawKeyboardListenerFocusNode,
      room: controller.room!,
      minLines: 1,
      maxLines: 8,
      autofocus: !PlatformInfos.isMobile,
      keyboardType: TextInputType.multiline,
      textInputAction: null,
      onSubmitted: (_) => controller.onInputBarSubmitted(),
      suggestionsController: controller.suggestionsController,
      typeAheadFocusNode: controller.inputFocus,
      controller: controller.sendController,
      focusSuggestionController: controller.focusSuggestionController,
      suggestionScrollController: controller.suggestionScrollController,
      showEmojiPickerNotifier: controller.showEmojiPickerNotifier,
      decoration: InputDecoration(
        hintText: L10n.of(context)!.message,
        isDense: true,
        hintMaxLines: 1,
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 12.0,
          ),
          child: SvgPicture.asset(
            ImagePaths.icMicrophone,
            height: 24,
            width: 24,
            fit: BoxFit.contain,
          ),
        ),
      ),
      onChanged: controller.onInputBarChanged,
    );
  }
}

class ActionSelectModeWidget extends StatelessWidget {
  final ChatController controller;

  const ActionSelectModeWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (controller.selectedEvents.first
              .getDisplayEvent(controller.timeline!)
              .status
              .isSent)
            SizedBox(
              height: ChatInputRowStyle.chatInputRowHeight,
              child: TextButton(
                onPressed: controller.forwardEventsAction,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.keyboard_arrow_left_outlined),
                    Text(L10n.of(context)!.forward),
                  ],
                ),
              ),
            ),
          if (controller.selectedEvents.length == 1) ...[
            if (controller.selectedEvents.first
                    .getDisplayEvent(controller.timeline!)
                    .status
                    .isSent &&
                controller
                    .selectedEvents.first.room.canSendDefaultMessages) ...[
              SizedBox(
                height: ChatInputRowStyle.chatInputRowHeight,
                child: TextButton(
                  onPressed: controller.replyAction,
                  child: Row(
                    children: <Widget>[
                      Text(L10n.of(context)!.reply),
                      const Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),
              ),
            ] else ...[
              const SizedBox.shrink(),
            ],
          ] else if (controller.selectedEvents.first
              .getDisplayEvent(controller.timeline!)
              .status
              .isError) ...[
            SizedBox(
              height: ChatInputRowStyle.chatInputRowHeight,
              child: TextButton(
                onPressed: controller.sendAgainAction,
                child: Row(
                  children: <Widget>[
                    Text(L10n.of(context)!.tryToSendAgain),
                    const SizedBox(width: 4),
                    SvgPicture.asset(ImagePaths.icSend),
                  ],
                ),
              ),
            ),
          ] else ...[
            const SizedBox.shrink(),
          ],
        ],
      ),
    );
  }
}

class ChatAccountPicker extends StatelessWidget {
  final ChatController controller;

  const ChatAccountPicker(this.controller, {super.key});

  void _popupMenuButtonSelected(String mxid) {
    final client = controller.matrix!.currentBundle!
        .firstWhere((cl) => cl!.userID == mxid, orElse: () => null);
    if (client == null) {
      Logs().w('Attempted to switch to a non-existing client $mxid');
      return;
    }
    controller.setSendingClient(client);
  }

  @override
  Widget build(BuildContext context) {
    controller.matrix ??= Matrix.of(context);
    final clients = controller.currentRoomBundle;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<Profile>(
        future: controller.sendingClient!.fetchOwnProfile(),
        builder: (context, snapshot) => PopupMenuButton<String>(
          onSelected: _popupMenuButtonSelected,
          itemBuilder: (BuildContext context) => clients
              .map(
                (client) => PopupMenuItem<String>(
                  value: client!.userID,
                  child: FutureBuilder<Profile>(
                    future: client.fetchOwnProfile(),
                    builder: (context, snapshot) => ListTile(
                      leading: Avatar(
                        mxContent: snapshot.data?.avatarUrl,
                        name: snapshot.data?.displayName ??
                            client.userID!.localpart,
                        size: 20,
                      ),
                      title: Text(snapshot.data?.displayName ?? client.userID!),
                      contentPadding: const EdgeInsets.all(0),
                    ),
                  ),
                ),
              )
              .toList(),
          child: Avatar(
            mxContent: snapshot.data?.avatarUrl,
            name: snapshot.data?.displayName ??
                controller.matrix!.client.userID!.localpart,
            size: 20,
            fontSize: 8,
          ),
        ),
      ),
    );
  }
}
