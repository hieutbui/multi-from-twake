import 'package:auth_buttons/auth_buttons.dart';
import 'package:fluffychat/pages/registration_with_email/registration_with_email.dart';
import 'package:fluffychat/pages/registration_with_email/registration_with_email_view_style.dart';
import 'package:fluffychat/widgets/app_bars/registration_app_bar.dart';
import 'package:fluffychat/widgets/multi_registraion_password_input_field.dart';
import 'package:fluffychat/widgets/multi_registration_button.dart';
import 'package:fluffychat/widgets/multi_registration_email_input_field.dart';
import 'package:fluffychat/widgets/multi_registration_title_with_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegistrationWithEmailView extends StatelessWidget {
  final RegistrationWithEmailController controller;

  const RegistrationWithEmailView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RegistrationWithEmailViewStyle.decoration,
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
                  title: 'Create your account',
                ),
                const SizedBox(height: 12.0),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Let’s set things up to make ',
                        style: TextStyle(
                          color: Colors.white
                              .withAlpha(153) /* Text-Main-Secondary */,
                          fontSize: 17,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.41,
                        ),
                      ),
                      TextSpan(
                        text: 'Multi',
                        style: TextStyle(
                          color: Colors.white
                              .withAlpha(222) /* Text-Main-Primary_Default */,
                          fontSize: 17,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.41,
                        ),
                      ),
                      TextSpan(
                        text: ' truly yours',
                        style: TextStyle(
                          color: Colors.white
                              .withAlpha(153) /* Text-Main-Secondary */,
                          fontSize: 17,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.41,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 78.0),
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
                          controller: controller.emailController,
                        ),
                        const SizedBox(height: 20.0),
                        MultiRegistrationPasswordInputField(
                          fieldKey: controller.passwordFieldKey,
                          focusNode: controller.passwordFocusNode,
                          isRequired: true,
                          controller: controller.passwordController,
                        ),
                        const SizedBox(height: 32.0),
                        MultiRegistrationButton(
                          label: 'Create an account',
                          type:
                              MultiRegistrationButtonType.mainSecondaryDisabled,
                          onPressed: controller.onTapCreateAccount,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'By continuing, you agree to our ',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Colors.white
                                  .withAlpha(153) /* Text-Main-Secondary */,
                              fontSize: 13,
                              letterSpacing: -0.08,
                              height: 1.38,
                            ),
                      ),
                      TextButton(
                        onPressed: controller.onTapRule,
                        child: Text(
                          'Rules',
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Colors.white.withAlpha(
                                      222,
                                    ) /* Text-Main-Primary_Default */,
                                    fontSize: 13,
                                    letterSpacing: -0.08,
                                    height: 1.38,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.white
                              .withAlpha(38) /* Additional-Divider */,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'or',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    height: 1.20,
                                    letterSpacing: -0.24,
                                    color: Colors.white.withAlpha(
                                      153,
                                    ) /* Text-Reversed-Secondary */,
                                  ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.white
                              .withAlpha(38) /* Additional-Divider */,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: AppleAuthButton(
                    onPressed: controller.onContinueWithApple,
                    text: 'Continue with Apple',
                    style: AuthButtonStyle(
                      buttonColor: const Color(
                        0x26EAECF5,
                      ),
                      iconSize: 18,
                      iconColor: Colors.black.withAlpha(222),
                      height: 48,
                      width: double.infinity,
                      textStyle:
                          RegistrationWithEmailViewStyle.buttonGreyTextStyle(
                        context,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GoogleAuthButton(
                    onPressed: controller.onContinueWithGoogle,
                    text: 'Continue with Google',
                    style: AuthButtonStyle(
                      buttonColor: const Color(
                        0x26EAECF5,
                      ) /* Buttons-Main-Secondary-Default */,
                      iconSize: 18,
                      iconColor: Colors.white.withAlpha(222),
                      height: 48,
                      width: double.infinity,
                      textStyle:
                          RegistrationWithEmailViewStyle.buttonGreyTextStyle(
                        context,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Already have an account?',
                      style:
                          RegistrationWithEmailViewStyle.haveAccountTextStyle(
                        context,
                      ),
                    ),
                    TextButton(
                      onPressed: controller.onTapLogin,
                      child: Text(
                        'Log In',
                        style: RegistrationWithEmailViewStyle.loginTextStyle(
                          context,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
