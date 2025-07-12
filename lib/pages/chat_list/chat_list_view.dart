import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/pages/chat_list/chat_list.dart';
import 'package:fluffychat/pages/chat_list/chat_list_body_view.dart';
import 'package:fluffychat/pages/chat_list/chat_list_bottom_navigator.dart';
import 'package:fluffychat/pages/chat_list/chat_list_bottom_navigator_style.dart';
import 'package:fluffychat/pages/chat_list/chat_list_header_style.dart';
import 'package:fluffychat/pages/chat_list/chat_list_view_style.dart';
import 'package:fluffychat/pages/search/search.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:fluffychat/widgets/mixins/popup_menu_widget_style.dart';
import 'package:fluffychat/widgets/swipe_to_dismiss_wrap.dart';
import 'package:fluffychat/widgets/twake_components/twake_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_shortcuts/keyboard_shortcuts.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
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
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      appBar: PreferredSize(
        preferredSize: ChatListViewStyle.preferredSizeAppBar(context),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.50, -0.00),
                end: Alignment(0.50, 1.00),
                colors: [Color(0xFF0E0F13), Color(0xFF232631)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(
                top: 12.0 + MediaQuery.of(context).padding.top,
              ),
              padding: const EdgeInsets.only(
                bottom: 20,
                left: 20,
                right: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        L10n.of(context)!.chats,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                              fontSize: MultiMobileTypography.headlineFontSmall,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                      ),
                      const SizedBox(width: 12.0),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 6,
                          left: 2,
                          right: 12,
                          bottom: 6,
                        ),
                        decoration: ShapeDecoration(
                          color: Theme.of(context).brightness ==
                                  Brightness.light
                              ? MultiLightColors.buttonsMainSecondary15Opasity
                              : MultiDarkColors.buttonsMainSecondary15Opasity,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 2.0),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 5,
                              ),
                              decoration: ShapeDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? MultiLightColors.additionalAccentBlueMain
                                    : MultiDarkColors.additionalAccentBlueMain,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: ValueListenableBuilder(
                                valueListenable:
                                    controller.unreadRoomCountNotifier,
                                builder: (context, value, child) {
                                  return Text(
                                    value.toString(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: const Color(0xFFEFF0FE),
                                        ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              L10n.of(context)!.unread,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  _normalModeWidgetsMobile(context),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.black.withOpacity(0.5),
          // backgroundColor: Colors.red,
          automaticallyImplyLeading: false,
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: controller.conversationSelectionNotifier,
        builder: (context, conversationSelection, __) {
          if (conversationSelection.isNotEmpty) {
            return ChatListBottomNavigator(
              bottomNavigationActionsWidget:
                  controller.bottomNavigationActionsWidget(
                paddingIcon: ChatListBottomNavigatorStyle.paddingIcon,
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
      body: StreamBuilder<Client>(
        stream: controller.clientStream,
        builder: (context, snapshot) {
          return ChatListBodyView(controller);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ValueListenableBuilder(
        valueListenable: controller.selectModeNotifier,
        builder: (context, _, __) {
          if (controller.isSelectMode) return const SizedBox();
          return KeyBoardShortcuts(
            keysToPress: {
              LogicalKeyboardKey.controlLeft,
              LogicalKeyboardKey.keyN,
            },
            onKeysPressed: () => controller.goToNewPrivateChat(),
            helpLabel: L10n.of(context)!.newChat,
            child: !responsiveUtils.isSingleColumnLayout(context)
                ? MenuAnchor(
                    menuChildren: [
                      MenuItemButton(
                        leadingIcon: const Icon(Icons.chat),
                        child: Text(
                          L10n.of(context)!.newDirectMessage,
                          style: PopupMenuWidgetStyle.defaultItemTextStyle(
                            context,
                          ),
                        ),
                        onPressed: () => controller.goToNewPrivateChat(),
                      ),
                      MenuItemButton(
                        leadingIcon: const Icon(Icons.group),
                        onPressed: () => controller.goToNewGroupChat(context),
                        child: Text(
                          L10n.of(context)!.newGroupChat,
                          style: PopupMenuWidgetStyle.defaultItemTextStyle(
                            context,
                          ),
                        ),
                      ),
                    ],
                    style: MenuStyle(
                      alignment: Alignment.topLeft,
                      backgroundColor: WidgetStatePropertyAll(
                        PopupMenuWidgetStyle.defaultMenuColor(context),
                      ),
                    ),
                    builder: (context, menuController, child) {
                      return TwakeFloatingActionButton(
                        icon: Icons.mode_edit_outline_outlined,
                        size: ChatListViewStyle.editIconSize,
                        onTap: () => menuController.open(),
                      );
                    },
                  )
                : TwakeFloatingActionButton(
                    icon: Icons.mode_edit_outline_outlined,
                    size: ChatListViewStyle.editIconSize,
                    onTap: controller.goToNewPrivateChat,
                  ),
          );
        },
      ),
    );
  }

  Widget _normalModeWidgetsMobile(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateWithSlideAnimation(context),
      child: TextField(
        textInputAction: TextInputAction.search,
        enabled: false,
        decoration: ChatListHeaderStyle.searchInputDecoration(context),
      ),
    );
  }

  void _navigateWithSlideAnimation(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const SwipeToDismissWrap(
            child: Search(),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          final tween = Tween(begin: begin, end: end).chain(
            CurveTween(
              curve: curve,
            ),
          );
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
