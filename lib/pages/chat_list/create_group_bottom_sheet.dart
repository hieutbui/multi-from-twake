import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/pages/chat_list/chat_list.dart';
import 'package:fluffychat/pages/chat_list/chat_list_tab_bar_styles.dart';
import 'package:fluffychat/widgets/twake_components/twake_icon_button.dart';
import 'package:flutter/material.dart';

class CreateGroupBottomSheet extends StatelessWidget {
  const CreateGroupBottomSheet({super.key, required this.controller});

  final ChatListController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(
        12,
        12,
        12,
        MediaQuery.of(context).viewInsets.bottom + 12,
      ),
      padding: const EdgeInsetsDirectional.all(20),
      decoration: BoxDecoration(
        color: MultiColors.of(context).backgroundSecondary,
        borderRadius: const BorderRadius.all(
          Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 44,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    "New Folder",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: TwakeIconButton(
                    onTap: controller.closeBottomSheet,
                    icon: Icons.close,
                    color:
                        MultiColors.of(context).buttonsMainSecondary15Opasity,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            decoration: ChatListTabBarStyles.folderNameInputDecoration(context),
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: controller.navigateToNewFolder,
            child: TextField(
              enabled: false,
              decoration: ChatListTabBarStyles.addChatInputDecoration(context),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Choose chats or types of chats that will appear in this folder",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: MultiColors.of(context).textMainSecondary,
                ),
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  MultiColors.of(context).buttonsMainSecondaryDefault,
            ),
            onPressed: () {},
            child: Text(
              "Create a folder",
              style: TextStyle(
                fontSize: MultiMobileTypography.buttonFontLarge,
                fontWeight: FontWeight.w500,
                color: MultiColors.of(context).textMainPrimaryDefault,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
