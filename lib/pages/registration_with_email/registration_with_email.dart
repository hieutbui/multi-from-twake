import 'dart:async';
import 'package:dartz/dartz.dart' hide State;
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/auth/signin_state.dart';
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

  final ValueNotifier<Either<Failure, Success>> signinNotifier =
      ValueNotifier<Either<Failure, Success>>(
    const Right(SignupInitial()),
  );

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  StreamSubscription? signupSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    registrationFormKey.currentState?.dispose();
    emailFieldKey.currentState?.dispose();
    passwordFieldKey.currentState?.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.removeListener(() {});
    passwordFocusNode.removeListener(() {});
    emailController.dispose();
    passwordController.dispose();
    signupSubscription?.cancel();
    signinNotifier.dispose();
    super.dispose();
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

  void onTapCreateAccount() {
    // Validate form
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
      firstName: 'Test123122',
      lastName: 'User',
      username: 'test123122',
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
    if (failure is SigninFailure) {
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
        extra: emailController.text, // Pass email as extra parameter
      );
    }
  }

  void onTapLogin() {
    //TODO: Implement onTapLogin
  }

  @override
  Widget build(BuildContext context) =>
      RegistrationWithEmailView(controller: this);
}
