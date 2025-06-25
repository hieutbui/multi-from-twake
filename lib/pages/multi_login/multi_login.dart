import 'dart:async';

import 'package:dartz/dartz.dart' hide State;
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/usecase/auth/signin_interactor.dart';
import 'package:fluffychat/pages/multi_login/multi_login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MultiLogin extends StatefulWidget {
  const MultiLogin({super.key});

  @override
  State<MultiLogin> createState() => MultiLoginController();
}

class MultiLoginController extends State<MultiLogin> {
  // Form keys
  final GlobalKey<FormBuilderState> registrationFormKey =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderFieldState> emailFieldKey =
      GlobalKey<FormBuilderFieldState>();
  final GlobalKey<FormBuilderFieldState> passwordFieldKey =
      GlobalKey<FormBuilderFieldState>();

  // Text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Focus nodes
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  // Interactor
  final SigninInteractor _signinInteractor = getIt<SigninInteractor>();

  // Stream subscription
  StreamSubscription? _signinSubscription;

  // UI state
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _signinSubscription?.cancel();
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
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Please enter both email and password';
      });
      return;
    }

    // Validate form
    if (!(registrationFormKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    // Cancel previous subscription if exists
    _signinSubscription?.cancel();

    // Execute interactor and listen for state changes
    _signinSubscription = _signinInteractor
        .execute(
          email: email,
          password: password,
        )
        .listen(_handleSigninState);
  }

  void onTapSignUp() {
    context.push('/home/multiRegistration');
  }

  // Handle state changes from the interactor stream
  void _handleSigninState(Either<Failure, Success> state) {}

  void onTapForgotPassword() {
    context.push('/home/forgotPassword');
  }

  @override
  Widget build(BuildContext context) => MultiLoginView(controller: this);
}
