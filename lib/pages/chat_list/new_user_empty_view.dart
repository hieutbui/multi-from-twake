import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/pages/chat_list/chat_list.dart';
import 'package:fluffychat/pages/chat_list/chat_list_tab_bar_widget.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:flutter/material.dart';

class NewUserEmptyView extends StatelessWidget {
  const NewUserEmptyView({super.key, required this.controller});

  final ChatListController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ChatListTabBarWidget(
          controller: controller,
        ),
        const SizedBox(
          height: 40,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Find your contacts",
                  style: TextStyle(
                    fontSize: MultiMobileTypography.headlineFontSmall,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.66,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Keep up with updates and chats\n from you friends and contacts",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MultiColors.of(context).textMainSecondary,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 60 / 366,
                  ),
                  child: Image.asset(
                    ImagePaths.imgRegistrationContacts,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: controller.isContactPermissionGranted,
                  builder: (context, isContactPermissionGranted, _) {
                    if (isContactPermissionGranted) {
                      return const SizedBox.shrink();
                    }
                    return GestureDetector(
                      onTap: controller.onTapEnableAccessContact,
                      child: Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color:
                              MultiColors.of(context).buttonsMainPrimaryDefault,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              MultiMobileRoundnessAndPaddings
                                  .roundnessButtonsSmall,
                            ),
                          ),
                        ),
                        child: Text(
                          "Enable access ",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                color:
                                    MultiColors.of(context).textReversedPrimary,
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
