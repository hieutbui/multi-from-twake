import 'package:fluffychat/pages/forgot_password/forgot_password.dart';
import 'package:fluffychat/widgets/app_bars/registration_app_bar.dart';
import 'package:fluffychat/widgets/multi_registration_button.dart';
import 'package:fluffychat/widgets/multi_registration_email_input_field.dart';
import 'package:fluffychat/widgets/multi_registration_title_with_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ForgotPasswordView extends StatelessWidget {
  final ForgotPasswordController controller;

  const ForgotPasswordView({super.key, required this.controller});

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
                  title: 'We’ve got your back',
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter your email and we’ll send you a link to reset your password',
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
                FormBuilder(
                  key: controller.registrationFormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        MultiRegistrationEmailInputField(
                          fieldKey: controller.emailFieldKey,
                          focusNode: controller.emailFocusNode,
                          isRequired: true,
                        ),
                        const SizedBox(height: 32.0),
                        MultiRegistrationButton(
                          label: 'Continue',
                          type:
                              MultiRegistrationButtonType.mainSecondaryDisabled,
                          onPressed: controller.onTapCreateAccount,
                        ),
                      ],
                    ),
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
