import 'dart:async';

import 'package:dartz/dartz.dart' hide State;
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/auth/signin_state.dart';
import 'package:fluffychat/domain/usecase/auth/signin_interactor.dart';
import 'package:fluffychat/pages/registration_with_email/registration_with_email_view.dart';
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
  final _signinInteractor = getIt.get<SigninInteractor>();

  final GlobalKey<FormBuilderState> registrationFormKey =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderFieldState> emailFieldKey =
      GlobalKey<FormBuilderFieldState>();
  final GlobalKey<FormBuilderFieldState> passwordFieldKey =
      GlobalKey<FormBuilderFieldState>();

  final ValueNotifier<Either<Failure, Success>> signinNotifier =
      ValueNotifier<Either<Failure, Success>>(
    const Right(SigninInitialState()),
  );

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  StreamSubscription? signinSubscription;

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both email and password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    signinSubscription = _signinInteractor
        .execute(
          email: email,
          password: password,
        )
        .listen(
          (event) => signinNotifier.value = event,
        );

    // Store password securely for later use in registration flow
    // TODO: Consider storing password in a more secure way

    // Navigate to code verification page with email
    context.push(
      '/home/codeVerification',
      extra: email, // Pass email as extra parameter
    );
  }

  void onTapLogin() {
    //TODO: Implement onTapLogin
  }

  @override
  Widget build(BuildContext context) =>
      RegistrationWithEmailView(controller: this);
}
