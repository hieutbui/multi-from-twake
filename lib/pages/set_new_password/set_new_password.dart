import 'dart:async';

import 'package:fluffychat/pages/set_new_password/set_new_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class SetNewPassword extends StatefulWidget {
  // Email that was verified in code verification page
  final String email;

  const SetNewPassword({super.key, required this.email});

  @override
  State<SetNewPassword> createState() => SetNewPasswordController();
}

class SetNewPasswordController extends State<SetNewPassword> {
  // UI state
  bool isLoading = false;
  String? errorMessage;
  final GlobalKey<FormBuilderState> registrationFormKey =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderFieldState> emailFieldKey =
      GlobalKey<FormBuilderFieldState>();
  final GlobalKey<FormBuilderFieldState> passwordFieldKey =
      GlobalKey<FormBuilderFieldState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Pre-fill email from verification step
    emailController.text = widget.email;
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
    // This function should update the password after verification
    final password = passwordController.text;

    if (password.isEmpty) {
      setState(() {
        errorMessage = 'Password cannot be empty';
      });
      return;
    }

    if (password.length < 8) {
      setState(() {
        errorMessage = 'Password must be at least 8 characters';
      });
      return;
    }

    // In a real implementation, we would use a ResetPasswordInteractor here
    // For now, we'll simulate the pattern with direct state management

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    // Simulate API call delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });

      // Navigate to login page on success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password has been reset successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to login screen
      context.go('/home/multiLogin');
    });

    /* 
    // This is how we would implement with a proper interactor:
    
    _resetPasswordSubscription?.cancel();
    _resetPasswordSubscription = _resetPasswordInteractor
        .execute(
          email: widget.email,
          password: password,
        )
        .listen(_handleResetPasswordState);
    */
  }

  void onTapLogin() {
    // Navigate back to login page
    context.push('/home/multiLogin');
  }

  @override
  Widget build(BuildContext context) => SetNewPasswordView(controller: this);
}
