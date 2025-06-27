import 'package:auth_buttons/auth_buttons.dart';
import 'package:fluffychat/pages/multi_login/multi_login.dart';
import 'package:fluffychat/pages/multi_login/multi_login_view_style.dart';
import 'package:fluffychat/widgets/app_bars/registration_app_bar.dart';
import 'package:fluffychat/widgets/multi_registraion_password_input_field.dart';
import 'package:fluffychat/widgets/multi_registration_button.dart';
import 'package:fluffychat/widgets/multi_registration_email_input_field.dart';
import 'package:fluffychat/widgets/multi_registration_title_with_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MultiLoginView extends StatelessWidget {
  final MultiLoginController controller;

  const MultiLoginView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MultiLoginViewStyle.decoration,
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
                  title: 'Welcome back',
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: MultiLoginViewStyle.padding,
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome back to ',
                          style: TextStyle(
                            color: Colors.white
                                .withAlpha(153) /* Text-Main-Secondary */,
                            fontSize: 17,
                            fontFamily: 'SFPro',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.41,
                          ),
                        ),
                        TextSpan(
                          text: 'Multi. ',
                          style: TextStyle(
                            color: Colors.white
                                .withAlpha(222) /* Text-Main-Primary_Default */,
                            fontSize: 17,
                            fontFamily: 'SFPro',
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.41,
                          ),
                        ),
                        TextSpan(
                          text: '\nPlease choose any option to login',
                          style: TextStyle(
                            color: Colors.white
                                .withAlpha(153) /* Text-Main-Secondary */,
                            fontSize: 17,
                            fontFamily: 'SFPro',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.41,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 48.0),
                FormBuilder(
                  key: controller.registrationFormKey,
                  child: Padding(
                    padding: MultiLoginViewStyle.padding,
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
                          isShowPasswordStrength: false,
                          controller: controller.passwordController,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: controller.onTapForgotPassword,
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                                fontFamily: 'SFPro',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.41,
                              ),
                            ),
                          ),
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
                const SizedBox(height: 32.0),
                Padding(
                  padding: MultiLoginViewStyle.padding,
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
                  padding: MultiLoginViewStyle.padding,
                  child: AppleAuthButton(
                    onPressed: controller.onContinueWithApple,
                    text: 'Sign Up with Apple',
                    style: AuthButtonStyle(
                      buttonColor: const Color(
                        0x26EAECF5,
                      ),
                      iconSize: 18,
                      iconColor: Colors.black.withAlpha(222),
                      height: 48,
                      width: double.infinity,
                      textStyle:
                          MultiLoginViewStyle.buttonGreyTextStyle(context),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Padding(
                  padding: MultiLoginViewStyle.padding,
                  child: GoogleAuthButton(
                    onPressed: controller.onContinueWithGoogle,
                    text: 'Sign Up with Google',
                    style: AuthButtonStyle(
                      buttonColor: const Color(
                        0x26EAECF5,
                      ) /* Buttons-Main-Secondary-Default */,
                      iconSize: 18,
                      iconColor: Colors.white.withAlpha(222),
                      height: 48,
                      width: double.infinity,
                      textStyle:
                          MultiLoginViewStyle.buttonGreyTextStyle(context),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: MultiLoginViewStyle.haveAccountTextStyle(context),
                    ),
                    TextButton(
                      onPressed: controller.onTapSignUp,
                      child: Text(
                        'Sign Up',
                        style: MultiLoginViewStyle.loginTextStyle(context),
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
