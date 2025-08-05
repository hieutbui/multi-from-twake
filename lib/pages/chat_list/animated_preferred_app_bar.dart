import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/pages/chat_list/chat_list.dart';
import 'package:fluffychat/pages/chat_list/chat_list_header_style.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/widgets/twake_components/twake_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class _Constants {
  static const double appBarHeightInChatList = 136;
  static const double appBarHeightInSearch = 80;
}

class ChatListAnimatedAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final bool isShowSearchView;
  final ChatListController controller;
  final double statusBarHeight;

  const ChatListAnimatedAppBar({
    super.key,
    required this.isShowSearchView,
    required this.controller,
    required this.statusBarHeight,
  });

  @override
  State<ChatListAnimatedAppBar> createState() => _ChatListAnimatedAppBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(_Constants.appBarHeightInChatList + statusBarHeight);
}

class _ChatListAnimatedAppBarState extends State<ChatListAnimatedAppBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _height;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _height = Tween<double>(
      begin: _Constants.appBarHeightInChatList + widget.statusBarHeight,
      end: _Constants.appBarHeightInSearch + widget.statusBarHeight,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant ChatListAnimatedAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isShowSearchView != oldWidget.isShowSearchView) {
      if (widget.isShowSearchView) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return AnimatedBuilder(
      animation: _height,
      builder: (context, child) {
        return SizedBox(
          height: _height.value,
          child: AppBar(
            backgroundColor: Colors.black.withOpacity(0.5),
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              height: widget.isShowSearchView
                  ? _Constants.appBarHeightInSearch + topPadding
                  : _Constants.appBarHeightInChatList + topPadding,
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
                margin: EdgeInsets.only(top: 12 + topPadding),
                padding: const EdgeInsets.only(
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.vertical,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: widget.isShowSearchView
                          ? const SizedBox.shrink()
                          : _buildTopHeader(context),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: widget.controller.searchChatController,
                            textInputAction: TextInputAction.search,
                            focusNode: widget.controller.searchChatFocusNode,
                            enabled: true,
                            decoration:
                                ChatListHeaderStyle.searchInputDecoration(
                              context,
                            ),
                          ),
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: widget.isShowSearchView
                              ? Row(
                                  children: [
                                    const SizedBox(width: 16),
                                    GestureDetector(
                                      onTap: widget.controller.hideSearchView,
                                      child: Text(
                                        "Cancel",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              color: MultiColors.of(context)
                                                  .textMainAccent,
                                            ),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildTopHeader(BuildContext context) {
    return Column(
      key: const ValueKey('topHeader'),
      children: [
        Row(
          children: [
            Text(
              L10n.of(context)!.chats,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: MultiMobileTypography.headlineFontSmall,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                color: MultiColors.of(context).buttonsMainSecondary15Opasity,
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
                      color: MultiColors.of(context).additionalAccentBlueMain,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable:
                          widget.controller.unreadRoomCountNotifier,
                      builder: (context, value, child) {
                        return Text(
                          value.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: const Color(0xFFEFF0FE)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    L10n.of(context)!.unread,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            const Spacer(),
            TwakeIconButton(
              onTap: widget.controller.onTapMessagePushSquare,
              imagePath: ImagePaths.icMessagePlusSquare,
              size: 24,
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
