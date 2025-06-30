import 'package:fluffychat/pages/forgot_password/forgot_password.dart';
import 'package:fluffychat/pages/forgot_password/forgot_password_style.dart';
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
      decoration: ForgotPasswordStyle.decoration,
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
                  padding: ForgotPasswordStyle.padding,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter your email and we’ll send you a link to reset your password',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                ),
                const SizedBox(height: 48.0),
                FormBuilder(
                  key: controller.registrationFormKey,
                  child: Padding(
                    padding: ForgotPasswordStyle.padding,
                    child: Column(
                      children: [
                        MultiRegistrationEmailInputField(
                          fieldKey: controller.emailFieldKey,
                          focusNode: controller.emailFocusNode,
                          isRequired: true,
                          controller: controller.emailController,
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
