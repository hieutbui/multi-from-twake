import 'package:auth_buttons/auth_buttons.dart';
import 'package:dartz/dartz.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/domain/app_state/auth/signin_state.dart';
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                        ),
                        TextSpan(
                          text: 'Multi. ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        TextSpan(
                          text: '\nPlease choose any option to login',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
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
                          isValidatePasswordStrength: false,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: controller.onTapForgotPassword,
                            child: Text(
                              'Forgot Password?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        ValueListenableBuilder<bool>(
                          valueListenable: controller.isButtonEnabledNotifier,
                          builder: (context, isEnabled, _) {
                            return ValueListenableBuilder<
                                Either<Failure, Success>>(
                              valueListenable: controller.signinNotifier,
                              builder: (context, state, _) {
                                final isLoading = state.fold(
                                  (failure) => false,
                                  (success) => success is SigninLoading,
                                );
                                return MultiRegistrationButton(
                                  label: 'Continue',
                                  type: isEnabled
                                      ? MultiRegistrationButtonType
                                          .mainPrimaryDefault
                                      : MultiRegistrationButtonType
                                          .mainSecondaryDisabled,
                                  onPressed: isEnabled && !isLoading
                                      ? controller.onTapContinue
                                      : null,
                                  isLoading: isLoading,
                                );
                              },
                            );
                          },
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
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'or',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color:
                                    MultiColors.of(context).additionalDivider,
                              ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Theme.of(context).colorScheme.inverseSurface,
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
                      separator: 8.0,
                      buttonColor:
                          MultiColors.of(context).buttonsMainSecondaryDefault,
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
                  padding: MultiLoginViewStyle.padding,
                  child: GoogleAuthButton(
                    onPressed: controller.onContinueWithGoogle,
                    text: 'Sign Up with Google',
                    style: AuthButtonStyle(
                      separator: 8.0,
                      buttonColor:
                          MultiColors.of(context).buttonsMainSecondaryDefault,
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
                      'Don’t have an account? ',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                    TextButton(
                      onPressed: controller.onTapSignUp,
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
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
