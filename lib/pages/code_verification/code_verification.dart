import 'package:fluffychat/pages/code_verification/code_verification_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CodeVerification extends StatefulWidget {
  final String email;

  const CodeVerification({
    super.key,
    required this.email,
  });

  @override
  State<CodeVerification> createState() => CodeVerificationController();
}

class CodeVerificationController extends State<CodeVerification> {
  // OTP controllers and focus nodes
  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> otpFocusNodes = List.generate(6, (index) => FocusNode());

  // UI state
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    for (final controller in otpControllers) {
      controller.dispose();
    }
    for (final focusNode in otpFocusNodes) {
      focusNode.dispose();
    }
    for (final focusNode in otpFocusNodes) {
      focusNode.removeListener(() {});
    }

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

  void onTapCreateAccount() {}

  void onTapSignUp() {
    context.push('/home/multiRegistration');
  }

  void onTapForgotPassword() {
    //TODO: Implement onTapForgotPassword
  }

  void handleOtpInput(String value, int index) {
    if (value.isNotEmpty && value.length == 1) {
      if (index < 5) {
        otpFocusNodes[index + 1].requestFocus();
      } else {
        // If it's the last input, verify code automatically
        onTapCreateAccount();
      }
    }
  }

  @override
  Widget build(BuildContext context) => CodeVerificationView(controller: this);
}
