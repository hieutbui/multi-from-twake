import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/pages/chat_list/chat_list.dart';
import 'package:fluffychat/pages/chat_list/chat_list_tab_bar_styles.dart';
import 'package:fluffychat/widgets/avatar/avatar.dart';
import 'package:fluffychat/widgets/twake_components/twake_icon_button.dart';
import 'package:flutter/material.dart';

class EditGroupBottomSheet extends StatelessWidget {
  const EditGroupBottomSheet({super.key, required this.controller});

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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // TODO: Remove dummy data
                      Text(
                        "Folder Name",
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: MultiColors.of(context)
                                      .textMainPrimaryDefault,
                                ),
                      ),
                      // TODO: Remove dummy data
                      Text(
                        "12 chats, all AI chats",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: MultiColors.of(context).textMainSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
                TwakeIconButton(
                  onTap: controller.closeBottomSheet,
                  icon: Icons.close,
                  color: MultiColors.of(context).buttonsMainSecondary15Opasity,
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Stack(
              children: [
                TextFormField(
                  decoration:
                      ChatListTabBarStyles.folderNameEditInputDecoration(
                          context),
                  textAlignVertical: TextAlignVertical.bottom,
                  // TODO: Remove dummy data
                  initialValue: "Folder Name",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: MultiColors.of(context).textMainPrimaryDefault,
                      ),
                ),
                Positioned(
                  top: 10,
                  left: 12,
                  child: Text(
                    "Folder Name",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color:
                              MultiColors.of(context).textMainTertiaryDisabled,
                        ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: controller.navigateToNewFolder,
              child: TextField(
                enabled: false,
                decoration:
                    ChatListTabBarStyles.addChatInputDecoration(context),
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
              height: 24,
            ),
            Stack(
              children: [
                Container(
                  margin:
                      const EdgeInsets.only(top: 10, left: 24.5, right: 24.5),
                  height: 66,
                  decoration: BoxDecoration(
                    color: MultiColors.of(context).backgroundSurfacesDefault,
                    borderRadius: BorderRadius.circular(
                      MultiMobileRoundnessAndPaddings
                          .roundnessCardsSmallDropdowns,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: MultiColors.of(context).backgroundSurfacesDefault,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x66000000),
                        offset: Offset(0, 8),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // TODO: Remove dummy data
                      Avatar(
                        mxContent: Uri.parse("https://picsum.photos/200"),
                        name: "test",
                        size: 40,
                        fontSize: 32,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                            child: Text(
                              "Personal Chat",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: MultiColors.of(context)
                                    .textMainPrimaryDefault,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: 16,
                            child: Text(
                              "+ 33 (323) 273 282",
                              style: TextStyle(
                                fontSize: MultiMobileTypography.bodyFontSubhead,
                                fontWeight: FontWeight.w400,
                                color:
                                    MultiColors.of(context).textMainSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            MultiMobileRoundnessAndPaddings.roundnessButtons,
                          ),
                        ),
                      ),
                      backgroundColor:
                          MultiColors.of(context).buttonsMainSecondary15Opasity,
                    ),
                    child: Text(
                      "Reset",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color:
                                MultiColors.of(context).textMainPrimaryDefault,
                          ),
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            MultiMobileRoundnessAndPaddings.roundnessButtons,
                          ),
                        ),
                      ),
                      backgroundColor:
                          MultiColors.of(context).buttonsMainPrimaryDefault,
                    ),
                    child: Text(
                      "Save change",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: MultiColors.of(context).textReversedPrimary,
                          ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
