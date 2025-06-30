import 'dart:async';

import 'package:dartz/dartz.dart' hide State;
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/auth/sign_up_request.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/auth/verify_code_state.dart';
import 'package:fluffychat/domain/usecase/auth/verify_code_interactor.dart';
import 'package:fluffychat/pages/code_verification/code_verification_view.dart';
import 'package:fluffychat/utils/twake_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CodeVerification extends StatefulWidget {
  final SignupRequest? signupRequest;

  const CodeVerification({
    super.key,
    this.signupRequest,
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

  // ValueNotifier to track if the button should be enabled
  final ValueNotifier<bool> isButtonEnabledNotifier =
      ValueNotifier<bool>(false);

  static const int codeLength = 6;

  // Store the verification code
  String _verificationCode = '';

  // Store the OTP controllers from the OtpTextField
  List<TextEditingController> _otpControllers = [];

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
    // Dispose of any controllers
    for (final controller in _otpControllers) {
      controller.dispose();
    }

    verifyCodeSubscription?.cancel();
    codeVerificationNotifier.dispose();
    isButtonEnabledNotifier.dispose();
    super.dispose();
  }

  // Method to receive controllers from OtpTextField
  void setOtpControllers(List<TextEditingController?> controllers) {
    _otpControllers = controllers.whereType<TextEditingController>().toList();
  }

  // Called when any digit changes
  void onCodeChanged(String code) {
    _verificationCode = code;
    isButtonEnabledNotifier.value = code.length == codeLength;
  }

  // Called when the full code is entered
  void onCodeSubmit(String verificationCode) {
    _verificationCode = verificationCode;
    isButtonEnabledNotifier.value = true;

    // Auto-submit when code is complete
    if (verificationCode.length == codeLength) {
      onTapContinue();
    }
  }

  void onTapCreateAccount() {}

  void onTapContinue() {
    if (_verificationCode.length != codeLength) {
      TwakeSnackBar.show(context, 'Please enter a valid verification code');
      return;
    }

    if (widget.signupRequest == null) {
      TwakeSnackBar.show(context, 'Failed to verify code', isError: true);
      context.pop();
      return;
    }

    verifyCodeSubscription = _verifyCodeInteractor
        .execute(
      email: widget.signupRequest!.email,
      verificationCode: _verificationCode,
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
      context.push(
        '/home/registrationName',
        extra: widget.signupRequest,
      );
    }
  }

  @override
  Widget build(BuildContext context) => CodeVerificationView(controller: this);
}
