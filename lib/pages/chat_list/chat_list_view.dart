import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/pages/chat_list/animated_preferred_app_bar.dart';
import 'package:fluffychat/pages/chat_list/chat_list.dart';
import 'package:fluffychat/pages/chat_list/chat_list_body_view.dart';
import 'package:fluffychat/pages/chat_list/chat_list_bottom_navigator.dart';
import 'package:fluffychat/pages/chat_list/chat_list_bottom_navigator_style.dart';
import 'package:fluffychat/pages/search/search.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class ChatListView extends StatelessWidget {
  final ChatListController controller;
  final Widget? bottomNavigationBar;
  final VoidCallback? onOpenSearchPageInMultipleColumns;
  final ChatListBottomNavigatorBarIcon onTapBottomNavigation;

  final responsiveUtils = getIt.get<ResponsiveUtils>();

  ChatListView({
    super.key,
    required this.controller,
    this.bottomNavigationBar,
    this.onOpenSearchPageInMultipleColumns,
    required this.onTapBottomNavigation,
  });

  static const ValueKey bottomNavigationKey = ValueKey('BottomNavigation');

  static const ValueKey primaryNavigationKey =
      ValueKey('AdaptiveScaffoldPrimaryNavigation');

  static const ValueKey contacts = ValueKey('Contacts');

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ValueListenableBuilder(
        valueListenable: controller.isShowSearchView,
        builder: (context, isShowSearchView, _) {
          final statusBarHeight = MediaQuery.of(context).padding.top;
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: ChatListAnimatedAppBar(
              controller: controller,
              isShowSearchView: isShowSearchView,
              statusBarHeight: statusBarHeight,
            ),
            bottomNavigationBar: isShowSearchView
                ? const SizedBox.shrink()
                : ValueListenableBuilder(
                    valueListenable: controller.conversationSelectionNotifier,
                    builder: (context, conversationSelection, __) {
                      if (conversationSelection.isNotEmpty) {
                        return ChatListBottomNavigator(
                          bottomNavigationActionsWidget:
                              controller.bottomNavigationActionsWidget(
                            paddingIcon:
                                ChatListBottomNavigatorStyle.paddingIcon,
                            iconSize: ChatListBottomNavigatorStyle.iconSize,
                            width: ChatListBottomNavigatorStyle.width,
                            context: context,
                          ),
                        );
                      } else {
                        return bottomNavigationBar ?? const SizedBox();
                      }
                    },
                  ),
            body: isShowSearchView
                ? Search(
                    textEditingController: controller.searchChatController,
                  )
                : StreamBuilder<Client>(
                    stream: controller.clientStream,
                    builder: (context, snapshot) {
                      return ChatListBodyView(controller);
                    },
                  ),

            // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            // floatingActionButton: ValueListenableBuilder(
            //   valueListenable: controller.selectModeNotifier,
            //   builder: (context, _, __) {
            //     if (controller.isSelectMode) return const SizedBox();
            //     return KeyBoardShortcuts(
            //       keysToPress: {
            //         LogicalKeyboardKey.controlLeft,
            //         LogicalKeyboardKey.keyN,
            //       },
            //       onKeysPressed: () => controller.goToNewPrivateChat(),
            //       helpLabel: L10n.of(context)!.newChat,
            //       child: !responsiveUtils.isSingleColumnLayout(context)
            //           ? MenuAnchor(
            //               menuChildren: [
            //                 MenuItemButton(
            //                   leadingIcon: const Icon(Icons.chat),
            //                   child: Text(
            //                     L10n.of(context)!.newDirectMessage,
            //                     style: PopupMenuWidgetStyle.defaultItemTextStyle(
            //                       context,
            //                     ),
            //                   ),
            //                   onPressed: () => controller.goToNewPrivateChat(),
            //                 ),
            //                 MenuItemButton(
            //                   leadingIcon: const Icon(Icons.group),
            //                   onPressed: () => controller.goToNewGroupChat(context),
            //                   child: Text(
            //                     L10n.of(context)!.newGroupChat,
            //                     style: PopupMenuWidgetStyle.defaultItemTextStyle(
            //                       context,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //               style: MenuStyle(
            //                 alignment: Alignment.topLeft,
            //                 backgroundColor: WidgetStatePropertyAll(
            //                   PopupMenuWidgetStyle.defaultMenuColor(context),
            //                 ),
            //               ),
            //               builder: (context, menuController, child) {
            //                 return TwakeFloatingActionButton(
            //                   icon: Icons.mode_edit_outline_outlined,
            //                   size: ChatListViewStyle.editIconSize,
            //                   onTap: () => menuController.open(),
            //                 );
            //               },
            //             )
            //           : TwakeFloatingActionButton(
            //               icon: Icons.mode_edit_outline_outlined,
            //               size: ChatListViewStyle.editIconSize,
            //               onTap: controller.goToNewPrivateChat,
            //             ),
            //     );
            //   },
            // ),
          );
        },
      ),
    );
  }
}
