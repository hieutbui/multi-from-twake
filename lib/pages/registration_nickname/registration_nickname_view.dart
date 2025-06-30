import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/domain/app_state/auth/set_username_state.dart';
import 'package:fluffychat/domain/app_state/auth/signin_state.dart';
import 'package:fluffychat/pages/registration_name/registration_name_view_style.dart';
import 'package:fluffychat/pages/registration_nickname/registration_nickname.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/widgets/app_bars/registration_app_bar.dart';
import 'package:fluffychat/widgets/multi_registration_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationNicknameView extends StatelessWidget {
  final RegistrationNicknameController controller;

  const RegistrationNicknameView({super.key, required this.controller});

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
                              'Choose your Nickname',
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
                            TextFormField(
                              controller: controller.nicknameController,
                              onChanged: controller.handleNicknameInput,
                              focusNode: controller.nicknameFocusNode,
                              decoration: const InputDecoration(
                                labelText: 'Nickname',
                              ),
                              textInputAction: TextInputAction.done,
                              autofocus: true,
                            ),
                            const SizedBox(height: 16),
                            ValueListenableBuilder(
                              valueListenable: controller.nameSuggestions,
                              builder: (context, suggestions, child) {
                                return Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  alignment: WrapAlignment.start,
                                  children: suggestions.map((suggestion) {
                                    return GestureDetector(
                                      onTap: () => controller
                                          .selectNicknameSuggestion(suggestion),
                                      child: Container(
                                        height: 22,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                          vertical: 4.0,
                                        ),
                                        decoration: ShapeDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? MultiLightColors
                                                  .additionalBlackout
                                              : MultiDarkColors
                                                  .additionalBlackout,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              suggestion,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(
                                                  0.60,
                                                ), // Text-Reversed-Secondary
                                                fontSize: 12,
                                                fontFamily: 'SFPro',
                                                fontWeight: FontWeight.w400,
                                                height: 1.33,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            SvgPicture.asset(
                                              ImagePaths.icPlusCircle,
                                              width: 12,
                                              height: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Continue Button - Now outside of ScrollView and at the bottom
              Padding(
                padding: const EdgeInsets.all(20),
                child: ValueListenableBuilder(
                  valueListenable: controller.isButtonEnabledNotifier,
                  builder: (context, isEnabled, _) {
                    return ValueListenableBuilder(
                      valueListenable: controller.setUsernameNotifier,
                      builder: (context, usernameState, _) {
                        // Check if we're in a loading state from setting username
                        final bool isUsernameLoading = usernameState
                                .isRight() &&
                            usernameState
                                    .getOrElse(() => const SetUsernameInitial())
                                is SetUsernameLoading;

                        // Also check if we're in signin loading state after username is set
                        return ValueListenableBuilder(
                          valueListenable: controller.signinNotifier,
                          builder: (context, signinState, _) {
                            final bool isSigninLoading = signinState
                                    .isRight() &&
                                signinState
                                        .getOrElse(() => const SigninInitial())
                                    is SigninLoading;

                            // Button is loading if either username setting or signin is in progress
                            final bool isLoading =
                                isUsernameLoading || isSigninLoading;

                            return MultiRegistrationButton(
                              label: 'Continue',
                              type: isEnabled
                                  ? MultiRegistrationButtonType
                                      .mainPrimaryDefault
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
