import 'dart:async';

import 'package:dartz/dartz.dart' hide State;
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/auth/verify_code_state.dart';
import 'package:fluffychat/domain/usecase/auth/verify_code_interactor.dart';
import 'package:fluffychat/pages/code_verification/code_verification_view.dart';
import 'package:fluffychat/pages/code_verification/widgets/custom_otp_input.dart';
import 'package:fluffychat/utils/twake_snackbar.dart';
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
  final VerifyCodeInteractor _verifyCodeInteractor =
      getIt.get<VerifyCodeInteractor>();

  final ValueNotifier<Either<Failure, Success>> codeVerificationNotifier =
      ValueNotifier<Either<Failure, Success>>(
    const Right(VerifyCodeInitial()),
  );

  static const int codeLength = 6;

  // OTP controllers and focus nodes
  List<TextEditingController> otpControllers =
      List.generate(codeLength, (index) => TextEditingController());
  List<FocusNode> otpFocusNodes =
      List.generate(codeLength, (index) => FocusNode());

  // UI state
  bool isLoading = false;
  String? errorMessage;
  StreamSubscription? verifyCodeSubscription;

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
    verifyCodeSubscription?.cancel();
    codeVerificationNotifier.dispose();

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

  void onTapContinue() {
    final verificationCode =
        otpControllers.map((controller) => controller.text).join();

    if (verificationCode.length != 6) {
      TwakeSnackBar.show(context, 'Please enter a valid verification code');
      return;
    }

    verifyCodeSubscription = _verifyCodeInteractor
        .execute(
      email: widget.email,
      verificationCode: verificationCode,
    )
        .listen(
      (event) {
        codeVerificationNotifier.value = event;

        event.fold(
          (failure) => _handleVerifyCodeFailureState(failure),
          (success) => _handleVerifyCodeSuccessState(success),
        );
      },
    );
  }

  void onTapForgotPassword() {
    //TODO: Implement onTapForgotPassword
  }

  void handleOtpInput(String value, int index) {
    if (value.isNotEmpty && value.length == 1) {
      if (index < 5) {
        otpFocusNodes[index + 1].requestFocus();
      }
    }
  }

  List<Widget> generateCodeCells() {
    return List.generate(codeLength, buildCodeInput);
  }

  Widget buildCodeInput(int index) {
    return CustomOtpInput(
      controller: otpControllers[index],
      focusNode: otpFocusNodes[index],
      autoFocus: index == 0,
      onChanged: (value) {
        handleOtpInput(value, index);
      },
      onSubmitted: (value) {
        if (index < 5) {
          otpFocusNodes[index + 1].requestFocus();
        }
      },
    );
  }

  void _handleVerifyCodeFailureState(Failure failure) {
    if (failure is VerifyCodeFailure) {
      TwakeSnackBar.show(context, failure.exception, isError: true);
    } else {
      TwakeSnackBar.show(context, 'Failed to verify code', isError: true);
    }
  }

  void _handleVerifyCodeSuccessState(Success success) {
    if (success is VerifyCodeSuccess) {
      // Navigate to multi registration page
      context.push('/home/registrationName');
    }
  }

  @override
  Widget build(BuildContext context) => CodeVerificationView(controller: this);
}
