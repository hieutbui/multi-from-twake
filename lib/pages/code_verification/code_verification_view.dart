import 'package:fluffychat/pages/code_verification/code_verification.dart';
import 'package:fluffychat/pages/code_verification/code_verification_style.dart';
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
      decoration: CodeVerificationStyle.decoration,
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
                  padding: CodeVerificationStyle.padding,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "We've sent the code to the test@gmail.com.",
                    style: TextStyle(
                      color:
                          Colors.white.withAlpha(153) /* Text-Main-Secondary */,
                      fontSize: 17,
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.41,
                    ),
                  ),
                ),
                const SizedBox(height: 48.0),
                Container(
                  margin: CodeVerificationStyle.padding,
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: controller.generateCodeCells(),
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
