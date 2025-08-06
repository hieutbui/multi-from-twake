import 'package:auth_buttons/auth_buttons.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/domain/app_state/auth/signin_state.dart';
import 'package:fluffychat/pages/registration_with_email/registration_with_email.dart';
import 'package:fluffychat/pages/registration_with_email/registration_with_email_view_style.dart';
import 'package:fluffychat/widgets/app_bars/registration_app_bar.dart';
import 'package:fluffychat/widgets/multi_registraion_password_input_field.dart';
import 'package:fluffychat/widgets/multi_registration_button.dart';
import 'package:fluffychat/widgets/multi_registration_email_input_field.dart';
import 'package:fluffychat/widgets/multi_registration_title_with_background.dart';
import 'package:flutter/gestures.dart';
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
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Let’s set things up to make ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                            ),
                            TextSpan(
                              text: 'Multi',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                            TextSpan(
                              text: ' truly yours',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 78.0),
                FormBuilder(
                  autovalidateMode: AutovalidateMode.disabled,
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
                        ValueListenableBuilder(
                          valueListenable: controller.formValidNotifier,
                          builder: (context, formValid, child) {
                            return ValueListenableBuilder(
                              valueListenable: controller.signinNotifier,
                              builder: (context, value, child) {
                                return MultiRegistrationButton(
                                  label: 'Create an account',
                                  type: formValid
                                      ? MultiRegistrationButtonType
                                          .mainPrimaryDefault
                                      : MultiRegistrationButtonType
                                          .mainSecondaryDisabled,
                                  onPressed: formValid
                                      ? controller.onTapCreateAccount
                                      : null,
                                  isLoading:
                                      value.isRight() && value is SigninLoading,
                                  isDisabled: !formValid,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text.rich(
                    TextSpan(
                      text: 'By continuing, you agree to our ',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: MultiColors.of(context).textMainSecondary,
                          ),
                      children: [
                        TextSpan(
                          text: 'Rules',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: MultiColors.of(context)
                                        .textMainPrimaryDefault,
                                  ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = controller.onTapRule,
                        ),
                      ],
                    ),
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
                      separator: 8.0,
                      buttonColor:
                          MultiColors.of(context).buttonsMainSecondaryDefault,
                      borderRadius: 16,
                      iconSize: 18,
                      iconColor: Theme.of(context).colorScheme.onSurface,
                      height: 48,
                      width: double.infinity,
                      textStyle:
                          Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
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
                      separator: 8.0,
                      buttonColor:
                          MultiColors.of(context).buttonsMainSecondaryDefault,
                      borderRadius: 16,
                      iconSize: 18,
                      iconColor: Theme.of(context).colorScheme.onSurface,
                      height: 48,
                      width: double.infinity,
                      textStyle:
                          Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                    TextButton(
                      onPressed: controller.onTapLogin,
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Log In',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
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
