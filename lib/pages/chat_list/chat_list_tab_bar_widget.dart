import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/pages/chat_list/chat_list.dart';
import 'package:flutter/material.dart';

class ChatListTabBarWidget extends StatelessWidget {
  const ChatListTabBarWidget({
    super.key,
    required this.controller,
  });

  final ChatListController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                TabBar(
                  controller: controller.tabController,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  physics: const NeverScrollableScrollPhysics(),
                  dividerHeight: 0,
                  labelColor: MultiColors.of(context).textMainPrimaryDefault,
                  unselectedLabelColor:
                      MultiColors.of(context).textMainSecondary,
                  indicatorColor:
                      MultiColors.of(context).additionalAccentBlueMain,
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  labelPadding: const EdgeInsetsDirectional.only(
                    top: 12,
                    bottom: 8,
                    start: 16,
                    end: 16,
                  ),
                  tabs: const [
                    _TabBarFirstItem(),
                    _TabBarItemWidget(
                      title: "Inbox",
                    ),
                    _TabBarItemWidget(
                      title: "AI chat",
                    ),
                  ],
                ),
                const _AddGroupItem(),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: const Color(0xff738C96).withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}

class _TabBarItemWidget extends StatelessWidget {
  const _TabBarItemWidget({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}

class _TabBarFirstItem extends StatelessWidget {
  const _TabBarFirstItem();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 18,
          width: 18,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Icon(Icons.list),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          "Wall",
        ),
      ],
    );
  }
}

class _AddGroupItem extends StatelessWidget {
  const _AddGroupItem();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsetsDirectional.only(
          top: 12,
          bottom: 8,
          start: 16,
          end: 16,
        ),
        child: SizedBox(
          height: 18,
          width: 18,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Icon(
              Icons.add,
              color: MultiColors.of(context).textMainSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
