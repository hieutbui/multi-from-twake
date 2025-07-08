import 'package:desktop_drop/desktop_drop.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_sys_colors.dart';
import 'package:fluffychat/pages/chat/chat.dart';
import 'package:fluffychat/pages/chat/chat_event_list.dart';
import 'package:fluffychat/pages/chat/chat_input_action_row.dart';
import 'package:fluffychat/pages/chat/chat_loading_view.dart';
import 'package:fluffychat/pages/chat/chat_view_body_style.dart';
import 'package:fluffychat/pages/chat/chat_view_style.dart';
import 'package:fluffychat/pages/chat/disabled_chat_input_row.dart';
import 'package:fluffychat/pages/chat/events/edit_display.dart';
import 'package:fluffychat/pages/chat/events/message_content_mixin.dart';
import 'package:fluffychat/pages/chat/chat_pinned_events/pinned_events_view.dart';
import 'package:fluffychat/pages/chat/sticky_timestamp_widget.dart';
import 'package:fluffychat/pages/chat/tombstone_display.dart';
import 'package:fluffychat/presentation/model/chat/view_event_list_ui_state.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/utils/date_time_extension.dart';
import 'package:fluffychat/widgets/connection_status_header.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_mart/flutter_emoji_mart.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';
import 'package:matrix/matrix.dart';
import 'chat_input_row.dart';

class ChatViewBody extends StatelessWidget with MessageContentMixin {
  final ChatController controller;
  final List<Event>? events;

  const ChatViewBody(
    this.controller, {
    this.events,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (details) => controller.handleDragDone(details),
      onDragEntered: controller.onDragEntered,
      onDragExited: controller.onDragExited,
      child: Container(
        // color: controller.responsive.isMobile(context)
        //     ? MultiSysColors.material().surface
        //     : null,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [
              Color(0xFF0E0F13),
              Color(0xFF191B26),
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            if (Matrix.of(context).wallpaper != null)
              Image.file(
                Matrix.of(context).wallpaper!,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
              ),
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (controller.room!.pinnedEventIds.isNotEmpty)
                      const SizedBox(
                        height: ChatViewStyle.pinnedMessageHintHeight,
                      ),
                    Expanded(
                      child: GestureDetector(
                        onTap: controller.clearSingleSelectedEvent,
                        child: ValueListenableBuilder(
                          valueListenable:
                              controller.openingChatViewStateNotifier,
                          builder: (context, viewState, __) {
                            if (viewState is ViewEventListLoading ||
                                controller.timeline == null) {
                              return const ChatLoadingView();
                            }

                            if (viewState is ViewEventListSuccess) {
                              return ChatEventList(
                                controller: controller,
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
                    if (controller.room!.canSendDefaultMessages &&
                        controller.room!.membership == Membership.join) ...[
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          child: ValueListenableBuilder(
                            valueListenable: controller.isPendingChatNotifier,
                            builder: (context, isPending, _) {
                              Logs().d('chat_view_body:isPending: $isPending');
                              if (isPending) {
                                return Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    border: Border(
                                      top: BorderSide(
                                        color: LinagoraStateLayer(
                                          MultiSysColors.material().surfaceTint,
                                        ).opacityLayer3,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Waiting for partner to accept the request...',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return controller.room?.isAbandonedDMRoom ==
                                        true
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                          bottom: ChatViewBodyStyle
                                              .bottomSheetPadding(
                                            context,
                                          ),
                                          left: ChatViewBodyStyle
                                              .bottomSheetPadding(
                                            context,
                                          ),
                                          right: ChatViewBodyStyle
                                              .bottomSheetPadding(
                                            context,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton.icon(
                                              style: TextButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                foregroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .error,
                                              ),
                                              icon: const Icon(
                                                Icons.archive_outlined,
                                              ),
                                              onPressed: () =>
                                                  controller.leaveChat(
                                                context,
                                                controller.room,
                                              ),
                                              label: Text(
                                                L10n.of(context)!.leave,
                                              ),
                                            ),
                                            TextButton.icon(
                                              style: TextButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(16),
                                              ),
                                              icon: const Icon(
                                                Icons.chat_outlined,
                                              ),
                                              onPressed:
                                                  controller.recreateChat,
                                              label: Text(
                                                L10n.of(context)!.reopenChat,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : _inputMessageWidget(context);
                              }
                            },
                          ),
                        ),
                      ),
                    ] else ...[
                      const DisabledChatInputRow(),
                    ],
                  ],
                ),
                TombstoneDisplay(controller),
                Column(
                  children: [
                    PinnedEventsView(controller),
                    if (controller.room!.pinnedEventIds.isNotEmpty)
                      Divider(
                        height: ChatViewBodyStyle.dividerSize,
                        thickness: ChatViewBodyStyle.dividerSize,
                        color: Theme.of(context).dividerColor,
                      ),
                    SizedBox(
                      key: controller.stickyTimestampKey,
                      child: ValueListenableBuilder(
                        valueListenable: controller.stickyTimestampNotifier,
                        builder: (context, stickyTimestamp, child) {
                          return StickyTimestampWidget(
                            isStickyHeader: stickyTimestamp != null,
                            content: stickyTimestamp != null
                                ? stickyTimestamp.relativeTime(context)
                                : '',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: controller.draggingNotifier,
              builder: (context, dragging, _) {
                if (!dragging) return const SizedBox.shrink();
                return Container(
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.9),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.upload_outlined,
                    size: 100,
                  ),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: controller.showEmojiPickerComposerNotifier,
              builder: (context, display, _) {
                if (!display) return const SizedBox.shrink();
                return Positioned(
                  bottom: 72,
                  right: 64,
                  child: MouseRegion(
                    onHover: (_) {
                      controller.showEmojiPickerComposerNotifier.value = true;
                    },
                    onExit: (_) async {
                      await Future.delayed(const Duration(seconds: 1));
                      controller.showEmojiPickerComposerNotifier.value = false;
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      width: ChatController.defaultMaxWidthReactionPicker,
                      height: ChatController.defaultMaxHeightReactionPicker,
                      decoration: BoxDecoration(
                        color: LinagoraRefColors.material().primary[100],
                        borderRadius: BorderRadius.circular(
                          24,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x0000004D).withOpacity(0.15),
                            offset: const Offset(0, 4),
                            blurRadius: 8,
                            spreadRadius: 3,
                          ),
                          BoxShadow(
                            color: const Color(0x00000026).withOpacity(0.3),
                            offset: const Offset(0, 1),
                            blurRadius: 3,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: EmojiPicker(
                        emojiData: Matrix.of(context).emojiData,
                        recentEmoji:
                            controller.getRecentReactionsInteractor.execute(),
                        configuration: EmojiPickerConfiguration(
                          showRecentTab: true,
                          emojiStyle:
                              Theme.of(context).textTheme.headlineLarge!,
                          searchEmptyTextStyle: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                color:
                                    LinagoraRefColors.material().tertiary[30],
                              ),
                          searchEmptyWidget: SvgPicture.asset(
                            ImagePaths.icSearchEmojiEmpty,
                          ),
                          searchFocusNode: FocusNode(),
                        ),
                        itemBuilder: (
                          context,
                          emojiId,
                          emoji,
                          callback,
                        ) {
                          return MouseRegion(
                            onHover: (_) {},
                            child: EmojiItem(
                              textStyle:
                                  Theme.of(context).textTheme.headlineLarge!,
                              onTap: () {
                                callback(
                                  emojiId,
                                  emoji,
                                );
                              },
                              emoji: emoji,
                            ),
                          );
                        },
                        onEmojiSelected: (
                          emojiId,
                          emoji,
                        ) {
                          controller.typeEmoji(emoji);
                          controller.handleStoreRecentReactions(emoji);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputMessageWidget(BuildContext context) {
    return Container(
      // height: 144,
      decoration: controller.responsive.isMobile(context)
          ? ShapeDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
            )
          : null,
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ConnectionStatusHeader(),
          ValueListenableBuilder(
            valueListenable: controller.editEventNotifier,
            builder: (context, editEvent, _) {
              if (!controller.responsive.isMobile(context)) {
                return const SizedBox.shrink();
              }

              if (editEvent == null) return const SizedBox.shrink();
              return Padding(
                padding: ChatViewBodyStyle.inputBarPadding(context),
                child: EditDisplay(
                  editEventNotifier: controller.editEventNotifier,
                  onCloseEditAction: controller.cancelEditEventAction,
                  timeline: controller.timeline,
                ),
              );
            },
          ),
          const SizedBox(height: 8.0),
          ChatInputRow(controller),
          SizedBox(
            height: controller.responsive.isMobile(context) ? 12.0 : 12.0,
          ),
          ChatInputActionRow(
            controller: controller,
          ),
          const SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
