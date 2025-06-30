import 'dart:async';
import 'package:dartz/dartz.dart' hide State;
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/auth/sign_up_request.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/auth/signup_state.dart';
import 'package:fluffychat/domain/usecase/auth/signup_interactor.dart';
import 'package:fluffychat/pages/registration_with_email/registration_with_email_view.dart';
import 'package:fluffychat/utils/twake_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class RegistrationWithEmail extends StatefulWidget {
  const RegistrationWithEmail({super.key});

  @override
  State<RegistrationWithEmail> createState() =>
      RegistrationWithEmailController();
}

class RegistrationWithEmailController extends State<RegistrationWithEmail> {
  final _signupInteractor = getIt.get<SignupInteractor>();

  final GlobalKey<FormBuilderState> registrationFormKey =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderFieldState> emailFieldKey =
      GlobalKey<FormBuilderFieldState>();
  final GlobalKey<FormBuilderFieldState> passwordFieldKey =
      GlobalKey<FormBuilderFieldState>();

  final ValueNotifier<bool> formValidNotifier = ValueNotifier(false);
  final ValueNotifier<Either<Failure, Success>> signinNotifier =
      ValueNotifier<Either<Failure, Success>>(
    const Right(SignupInitial()),
  );

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  StreamSubscription? signupSubscription;

  // Track which fields have been touched by the user
  bool _emailTouched = false;
  bool _passwordTouched = false;
  bool _formTouched = false;

  @override
  void initState() {
    super.initState();

    // Listen for focus changes to determine which fields are touched
    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus && !_emailTouched) {
        setState(() {
          _emailTouched = true;
          _formTouched = true;
        });
      }
    });

    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus && !_passwordTouched) {
        setState(() {
          _passwordTouched = true;
          _formTouched = true;
        });
      }
    });

    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);

    WidgetsBinding.instance.addPostFrameCallback((_) => _validateForm());
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(() {});
    passwordFocusNode.removeListener(() {});
    emailController.removeListener(_validateForm);
    passwordController.removeListener(_validateForm);
    registrationFormKey.currentState?.dispose();
    emailFieldKey.currentState?.dispose();
    passwordFieldKey.currentState?.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    signupSubscription?.cancel();
    signinNotifier.dispose();
    formValidNotifier.dispose();
    super.dispose();
  }

  void _validateForm() {
    // Don't show validation errors before user interaction with any fields
    if (!_formTouched) {
      formValidNotifier.value = false;
      return;
    }

    // Check if fields have content (needed for button enable/disable)
    final hasEmail = emailController.text.isNotEmpty;
    final hasPassword = passwordController.text.isNotEmpty;

    // For form validation, we only use basic checks here for enabling the button
    // Full validation will happen on submit
    bool emailValid = true;
    bool passwordValid = true;

    if (_emailTouched) {
      // Simple email check for enabling button
      emailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
          .hasMatch(emailController.text);
    }

    if (_passwordTouched) {
      // Simple password check for enabling button (minimum 8 chars)
      passwordValid = passwordController.text.length >= 8;
    }

    // Update button state based on field content and basic validation
    formValidNotifier.value =
        hasEmail && hasPassword && emailValid && passwordValid;
  }

  void onTapCreateAccount() {
    // Mark all fields as touched to show validation errors if any
    setState(() {
      _emailTouched = true;
      _passwordTouched = true;
      _formTouched = true;
    });

    // Now validate the entire form
    if (!(registrationFormKey.currentState?.validate() ?? false)) {
      return;
    }

    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      TwakeSnackBar.show(
        context,
        'Please enter both email and password',
        isError: true,
      );
      return;
    }

    signupSubscription = _signupInteractor
        .execute(
      email: email,
      password: password,
    )
        .listen(
      (event) {
        signinNotifier.value = event;

        event.fold(
          (failure) => _handleSigninFailureState(failure),
          (success) => _handleSigninSuccessState(success),
        );
      },
    );
  }

  void _handleSigninFailureState(Failure failure) {
    if (failure is SignupFailure) {
      if (failure.exception == 'Email already registered') {
        TwakeSnackBar.show(context, 'Email already registered', isError: true);
      }
      TwakeSnackBar.show(context, failure.exception, isError: true);
    } else {
      TwakeSnackBar.show(context, 'Failed to sign in', isError: true);
    }
  }

  void _handleSigninSuccessState(Success success) {
    if (success is SignupSuccess) {
      // Navigate to code verification page with email
      context.push(
        '/home/codeVerification',
        extra: SignupRequest(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
    }
  }

  void onTapLogin() {
    context.push('/home/multiLogin');
  }

  void onTapRule() {
    // TODO: Implement onTapRule
  }

  void onContinueWithApple() {
    // TODO: Implement onContinueWithApple
  }

  void onContinueWithGoogle() {
    // TODO: Implement onContinueWithGoogle
  }

  @override
  Widget build(BuildContext context) =>
      RegistrationWithEmailView(controller: this);
}
