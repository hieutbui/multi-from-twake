import 'package:fluffychat/pages/registration_name/registration_name.dart';
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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0E0F13), Color(0xFF191B26)],
        ),
      ),
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
                        decoration: BoxDecoration(
                          color: const Color(0xFF374151).withAlpha(153),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
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
                                      fontFamily: 'SF Pro',
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
                                      fontFamily: 'SF Pro',
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
                        children: [
                          Text(
                            'What is your name?',
                            style: TextStyle(
                              color: Colors.white
                                  .withAlpha(153) /* Text-Main-Secondary */,
                              fontSize: 17,
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w400,
                              height: 1.18,
                              letterSpacing: -0.41,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: controller.nameController,
                            onChanged: controller.handleNameInput,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withAlpha(
                                222,
                              ) /* Text-Main-Primary_Default */,
                              fontSize: 34,
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w700,
                              height: 1.24,
                              letterSpacing: 0.37,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your name',
                              hintStyle: TextStyle(
                                color: Colors.white.withAlpha(
                                  128,
                                ) /* Text-Main-Primary_Default */,
                                fontSize: 34,
                                fontFamily: 'SF Pro',
                                fontWeight: FontWeight.w700,
                                height: 1.24,
                                letterSpacing: 0.37,
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
