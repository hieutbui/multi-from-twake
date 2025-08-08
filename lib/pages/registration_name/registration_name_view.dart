import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/domain/app_state/auth/set_display_name_state.dart';
import 'package:fluffychat/pages/registration_name/registration_name.dart';
import 'package:fluffychat/pages/registration_name/registration_name_view_style.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/widgets/app_bars/registration_app_bar.dart';
import 'package:fluffychat/widgets/multi_registration_button.dart';
import 'package:flutter/material.dart';

class RegistrationNameView extends StatelessWidget {
  final RegistrationNameController controller;

  const RegistrationNameView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RegistrationNameViewStyle.decoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const RegistrationAppBar(
          isShowLeading: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      // Main Content
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 60),

                            // AI Assistant Introduction Card
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: RegistrationNameViewStyle
                                  .helloContainerDecoration,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    ImagePaths.imgHello,
                                    width: 62,
                                    height: 62,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hey, I\'m MULTI 👋',
                                          style: TextStyle(
                                            color: Colors.white.withAlpha(
                                              222,
                                            ) /* Text-Reversed-Primary */,
                                            fontSize: 17,
                                            fontFamily: 'SFPro',
                                            fontWeight: FontWeight.w500,
                                            height: 1.29,
                                            letterSpacing: -0.41,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'I\'m here to help you plan smarter and stay organized',
                                          style: TextStyle(
                                            color: Colors.white.withAlpha(
                                              153,
                                            ) /* Text-Reversed-Secondary */,
                                            fontSize: 15,
                                            fontFamily: 'SFPro',
                                            fontWeight: FontWeight.w400,
                                            height: 1.20,
                                            letterSpacing: -0.24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 48),

                            Text(
                              'What is your name?',
                              style: TextStyle(
                                color: Colors.white
                                    .withAlpha(153) /* Text-Main-Secondary */,
                                fontSize: 17,
                                fontFamily: 'SFPro',
                                fontWeight: FontWeight.w400,
                                height: 1.18,
                                letterSpacing: -0.41,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: controller.nameController,
                              onChanged: controller.handleNameInput,
                              autocorrect: false,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                              decoration: InputDecoration(
                                hintText: 'Enter your name',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(
                                      color: MultiColors.of(context)
                                          .textMainTertiaryDisabled,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.all(20),
                child: ValueListenableBuilder(
                  valueListenable: controller.isButtonEnabledNotifier,
                  builder: (context, isEnabled, _) {
                    return ValueListenableBuilder(
                      valueListenable: controller.setDisplayNameNotifier,
                      builder: (context, state, _) {
                        final bool isLoading = state.isRight() &&
                            state.getOrElse(() => const SetDisplayNameInitial())
                                is SetDisplayNameLoading;

                        return MultiRegistrationButton(
                          label: 'Continue',
                          type: isEnabled
                              ? MultiRegistrationButtonType.mainPrimaryDefault
                              : MultiRegistrationButtonType
                                  .mainSecondaryDisabled,
                          onPressed:
                              isEnabled ? controller.onTapContinue : null,
                          isLoading: isLoading,
                          isDisabled: !isEnabled,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
