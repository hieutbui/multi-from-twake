import 'package:fluffychat/pages/code_verification/code_verification.dart';
import 'package:fluffychat/pages/code_verification/widgets/custom_otp_input.dart';
import 'package:fluffychat/widgets/app_bars/registration_app_bar.dart';
import 'package:fluffychat/widgets/multi_registration_button.dart';
import 'package:fluffychat/widgets/multi_registration_title_with_background.dart';
import 'package:flutter/material.dart';

class CodeVerificationView extends StatelessWidget {
  final CodeVerificationController controller;

  const CodeVerificationView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.50, -0.00),
          end: Alignment(0.50, 1.00),
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
                const SizedBox(height: 4.0),
                const MultiRegistrationTitleWithBackground(
                  title: 'Please check your email',
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "We've sent the code to the test@gmail.com.",
                    style: TextStyle(
                      color:
                          Colors.white.withAlpha(153) /* Text-Main-Secondary */,
                      fontSize: 17,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.41,
                    ),
                  ),
                ),
                const SizedBox(height: 48.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return CustomOtpInput(
                        controller: controller.otpControllers[index],
                        focusNode: controller.otpFocusNodes[index],
                        autoFocus: index == 0,
                        onChanged: (value) {
                          controller.handleOtpInput(value, index);
                        },
                        onSubmitted: (value) {
                          if (index < 5) {
                            controller.otpFocusNodes[index + 1].requestFocus();
                          }
                        },
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 32.0),
                MultiRegistrationButton(
                  label: 'Continue',
                  type: MultiRegistrationButtonType.mainSecondaryDisabled,
                  onPressed: controller.onTapCreateAccount,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
