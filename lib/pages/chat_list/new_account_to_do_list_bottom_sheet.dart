import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/pages/chat_list/chat_list.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/widgets/multi_registration_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewAccountToDoListBottomSheet extends StatelessWidget {
  const NewAccountToDoListBottomSheet({super.key, required this.controller});

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
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 20,
        vertical: 40,
      ),
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
          Text(
            "Where would you like\n to start?",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 28,
                  color: MultiColors.of(context).textMainPrimaryDefault,
                  fontWeight: FontWeight.w600,
                  height: 34 / 28,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 44,
          ),
          ValueListenableBuilder(
            valueListenable: controller.isNotificationPermissionGranted,
            builder: (context, isNotificationPermissionGranted, __) {
              return _NewAccountToDoListItem(
                label: "Enable notifications",
                description:
                    "Stay in the loop with updates, reminders, and smart tips",
                isCompleted: isNotificationPermissionGranted,
                onTap: () {
                  controller.onTapEnableNotification(context);
                },
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          _NewAccountToDoListItem(
            label: "Set up your account",
            description:
                "Personalize MULTI to fit your life from the very start",
            isCompleted: false,
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          _NewAccountToDoListItem(
            label: "Set up pin code or face ID",
            description: "Keep your data safe with fast, secure access",
            isCompleted: false,
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          _NewAccountToDoListItem(
            label: "Invite friends",
            description:
                "MULTI’s better together — share the experience in one tap.",
            isCompleted: false,
            onTap: () {},
          ),
          const SizedBox(
            height: 44,
          ),
          MultiRegistrationButton(
            label: 'Skip and go to the Chat',
            type: MultiRegistrationButtonType.mainSecondaryDefault,
            onPressed: controller.closeBottomSheet,
          ),
        ],
      ),
    );
  }
}

class _NewAccountToDoListItem extends StatelessWidget {
  const _NewAccountToDoListItem({
    required this.label,
    required this.description,
    required this.isCompleted,
    required this.onTap,
  });

  final String label;
  final String description;
  final bool isCompleted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isCompleted) return;
        onTap.call();
      },
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: const BoxDecoration(
                  color: Color(0xff384955),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              if (isCompleted)
                Positioned(
                  bottom: 4,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    ImagePaths.icCheckCircleGreen,
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isCompleted
                            ? MultiColors.of(context).textMainTertiaryDisabled
                            : MultiColors.of(context).textMainPrimaryDefault,
                      ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isCompleted
                            ? MultiColors.of(context).textMainTertiaryDisabled
                            : MultiColors.of(context).textMainSecondary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
