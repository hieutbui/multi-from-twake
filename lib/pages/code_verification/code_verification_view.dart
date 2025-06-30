import 'package:fluffychat/pages/code_verification/code_verification.dart';
import 'package:fluffychat/pages/code_verification/code_verification_style.dart';
import 'package:fluffychat/widgets/app_bars/registration_app_bar.dart';
import 'package:fluffychat/widgets/multi_registration_button.dart';
import 'package:fluffychat/widgets/multi_registration_title_with_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

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
                    "We've sent the code to the ${controller.widget.signupRequest?.email}.",
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
                  child: OtpTextField(
                    numberOfFields: CodeVerificationController.codeLength,
                    focusedBorderColor: const Color(0xFF3B82F6),
                    enabledBorderColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    showFieldAsBox: true,
                    borderWidth: 2.0,
                    fieldWidth: 48,
                    autoFocus: true,
                    clearText: false,
                    hasCustomInputDecoration: false,
                    keyboardType: TextInputType.number,
                    enabled: true,
                    textStyle: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SFPro',
                    ),
                    filled: true,
                    fillColor: const Color(0xFF1D1F26),
                    borderRadius: BorderRadius.circular(12),
                    onCodeChanged: controller.onCodeChanged,
                    onSubmit: controller.onCodeSubmit,
                  ),
                ),
                const SizedBox(height: 32.0),
                ValueListenableBuilder(
                  valueListenable: controller.isButtonEnabledNotifier,
                  builder: (context, isEnabled, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: MultiRegistrationButton(
                        label: 'Continue',
                        type: isEnabled
                            ? MultiRegistrationButtonType.mainPrimaryDefault
                            : MultiRegistrationButtonType.mainSecondaryDisabled,
                        onPressed: isEnabled ? controller.onTapContinue : null,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
