import 'dart:async';

import 'package:dartz/dartz.dart' hide State;
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/auth/set_display_name_request.dart';
import 'package:fluffychat/data/model/auth/sign_up_request.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/auth/set_display_name_state.dart';
import 'package:fluffychat/domain/usecase/auth/set_display_name_interactor.dart';
import 'package:fluffychat/pages/registration_name/registration_name_view.dart';
import 'package:fluffychat/pages/registration_nickname/models/registration_nickname_args.dart';
import 'package:fluffychat/utils/twake_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrationName extends StatefulWidget {
  final SignupRequest? signupRequest;

  const RegistrationName({
    super.key,
    this.signupRequest,
  });

  @override
  State<RegistrationName> createState() => RegistrationNameController();
}

class RegistrationNameController extends State<RegistrationName> {
  final SetDisplayNameInteractor _setDisplayNameInteractor =
      getIt.get<SetDisplayNameInteractor>();

  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();

  final ValueNotifier<Either<Failure, Success>> setDisplayNameNotifier =
      ValueNotifier<Either<Failure, Success>>(
    const Right(SetDisplayNameInitial()),
  );

  // ValueNotifier to track if the button should be enabled
  final ValueNotifier<bool> isButtonEnabledNotifier =
      ValueNotifier<bool>(false);

  StreamSubscription? _setDisplayNameSubscription;

  // UI state
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    // Listen to text changes to update button state
    nameController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    nameController.removeListener(_updateButtonState);
    nameController.dispose();
    nameFocusNode.dispose();
    isButtonEnabledNotifier.dispose();
    setDisplayNameNotifier.dispose();
    _setDisplayNameSubscription?.cancel();
    super.dispose();
  }

  // Update button enabled state based on valid input
  void _updateButtonState() {
    final name = nameController.text.trim();
    isButtonEnabledNotifier.value = name.length >= 2;
  }

  void handleNameInput(String value) {
    // Clear error when user starts typing
    if (errorMessage != null) {
      setState(() {
        errorMessage = null;
      });
    }
  }

  void onTapContinue() {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your name';
      });
      return;
    }

    // Clear any previous errors
    setState(() {
      errorMessage = null;
    });

    if (widget.signupRequest == null) {
      TwakeSnackBar.show(context, 'Failed to set username', isError: true);
      context.pop();
      return;
    }

    // Navigate to next page, passing the name data for later use
    // context.push('/home/registrationNickname');
    _setDisplayNameSubscription = _setDisplayNameInteractor
        .execute(
          SetDisplayNameRequest(
            displayName: name,
            email: widget.signupRequest!.email,
            password: widget.signupRequest!.password,
          ),
        )
        .listen(
          (state) => state.fold(
            (failure) => _handleSetUsernameFailureState(failure),
            (success) => _handleSetUsernameSuccessState(success),
          ),
        );
  }

  void _handleSetUsernameFailureState(Failure failure) {
    if (failure is SetDisplayNameFailure) {
      TwakeSnackBar.show(context, failure.exception.toString(), isError: true);
    } else {
      TwakeSnackBar.show(context, 'Failed to set username', isError: true);
    }
  }

  void _handleSetUsernameSuccessState(Success success) {
    if (success is SetDisplayNameSuccess) {
      if (widget.signupRequest == null) {
        TwakeSnackBar.show(context, 'Failed to set username', isError: true);
        context.pop();
        return;
      }

      // Navigate to next page, passing the name data for later use
      context.push(
        '/home/registrationNickname',
        extra: RegistrationNicknameArgs(
          email: widget.signupRequest!.email,
          password: widget.signupRequest!.password,
          displayName: nameController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => RegistrationNameView(controller: this);
}
