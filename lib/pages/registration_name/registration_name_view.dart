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
        appBar: const RegistrationAppBar(),
        body: SafeArea(
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
                        decoration:
                            RegistrationNameViewStyle.helloContainerDecoration,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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

                      // Name Input Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          const SizedBox(height: 24),

                          // First Name Field
                          Text(
                            'First Name',
                            style: TextStyle(
                              color: Colors.white.withAlpha(153),
                              fontSize: 15,
                              fontFamily: 'SFPro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: controller.firstNameController,
                            focusNode: controller.firstNameFocusNode,
                            onChanged: controller.handleFirstNameInput,
                            style: TextStyle(
                              color: Colors.white.withAlpha(222),
                              fontSize: 22,
                              fontFamily: 'SFPro',
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: RegistrationNameViewStyle
                                .nameTextFieldDecoration,
                          ),
                          const SizedBox(height: 20),

                          // Last Name Field
                          Text(
                            'Last Name',
                            style: TextStyle(
                              color: Colors.white.withAlpha(153),
                              fontSize: 15,
                              fontFamily: 'SFPro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: controller.lastNameController,
                            focusNode: controller.lastNameFocusNode,
                            onChanged: controller.handleLastNameInput,
                            style: TextStyle(
                              color: Colors.white.withAlpha(222),
                              fontSize: 22,
                              fontFamily: 'SFPro',
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: RegistrationNameViewStyle
                                .nameTextFieldDecoration,
                          ),

                          // Error message display
                          if (controller.errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                controller.errorMessage!,
                                style: TextStyle(
                                  color: Colors.red.shade300,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Continue Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MultiRegistrationButton(
                    label: 'Continue',
                    type: MultiRegistrationButtonType.mainSecondaryDisabled,
                    onPressed: controller.onTapCreateAccount,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
