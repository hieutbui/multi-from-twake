import 'dart:async';

import 'package:dartz/dartz.dart' hide State;
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/data/model/auth/get_username_suggestion_request.dart';
import 'package:fluffychat/data/model/auth/set_username_request.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/auth/get_username_suggestion_state.dart';
import 'package:fluffychat/domain/app_state/auth/set_username_state.dart';
import 'package:fluffychat/domain/app_state/auth/signin_state.dart';
import 'package:fluffychat/domain/usecase/auth/get_username_suggestion_interactor.dart';
import 'package:fluffychat/domain/usecase/auth/set_username_interactor.dart';
import 'package:fluffychat/domain/usecase/auth/signin_interactor.dart';
import 'package:fluffychat/pages/registration_nickname/models/registration_nickname_args.dart';
import 'package:fluffychat/pages/registration_nickname/registration_nickname_view.dart';
import 'package:fluffychat/pages/search/search_debouncer_mixin.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:fluffychat/utils/twake_snackbar.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matrix/matrix.dart';

class RegistrationNickname extends StatefulWidget {
  final RegistrationNicknameArgs? args;

  const RegistrationNickname({
    super.key,
    this.args,
  });

  @override
  State<RegistrationNickname> createState() => RegistrationNicknameController();
}

class RegistrationNicknameController extends State<RegistrationNickname>
    with SearchDebouncerMixin {
  final SetUsernameInteractor _setUsernameInteractor =
      getIt.get<SetUsernameInteractor>();
  final GetUsernameSuggestionInteractor _getUsernameSuggestionInteractor =
      getIt.get<GetUsernameSuggestionInteractor>();
  final SigninInteractor _signinInteractor = getIt.get<SigninInteractor>();

  final TextEditingController nicknameController = TextEditingController();
  final FocusNode nicknameFocusNode = FocusNode();

  final ValueNotifier<Either<Failure, Success>> setUsernameNotifier =
      ValueNotifier<Either<Failure, Success>>(
    const Right(SetUsernameInitial()),
  );
  final ValueNotifier<Either<Failure, Success>> getUsernameSuggestionNotifier =
      ValueNotifier<Either<Failure, Success>>(
    const Right(GetUsernameSuggestionInitial()),
  );
  final ValueNotifier<Either<Failure, Success>> signinNotifier =
      ValueNotifier<Either<Failure, Success>>(
    const Right(SigninInitial()),
  );

  // ValueNotifier to track if the button should be enabled
  final ValueNotifier<bool> isButtonEnabledNotifier =
      ValueNotifier<bool>(false);

  // List of name suggestions
  final ValueNotifier<List<String>> nameSuggestions = ValueNotifier([]);

  // UI state
  bool isLoading = false;
  String? errorMessage;

  StreamSubscription? _getUsernameSuggestionSubscription;
  StreamSubscription? _setUsernameSubscription;
  StreamSubscription? _signinSubscription;

  @override
  void initState() {
    super.initState();
    nicknameController.text = widget.args?.displayName ?? '';
    fetchUsernameSuggestion(widget.args?.displayName ?? '');
    initializeDebouncer((keyword) => fetchUsernameSuggestion(keyword));
    // Listen to text changes to update button state
    nicknameController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    nicknameController.removeListener(_updateButtonState);
    nicknameController.dispose();
    nicknameFocusNode.dispose();
    isButtonEnabledNotifier.dispose();
    getUsernameSuggestionNotifier.dispose();
    setUsernameNotifier.dispose();
    _getUsernameSuggestionSubscription?.cancel();
    _setUsernameSubscription?.cancel();
    _signinSubscription?.cancel();
    super.dispose();
  }

  void fetchUsernameSuggestion(String keyword) {
    if (widget.args == null) {
      TwakeSnackBar.show(context, 'Failed to set username', isError: true);
      context.pop();
      return;
    }

    _getUsernameSuggestionSubscription = _getUsernameSuggestionInteractor
        .execute(
      GetUsernameSuggestionRequest(
        displayName: keyword.isEmpty ? widget.args!.displayName : keyword,
      ),
    )
        .listen(
      (event) {
        getUsernameSuggestionNotifier.value = event;
        event.fold(
          (failure) => _handleGetUsernameSuggestionFailureState(failure),
          (success) => _handleGetUsernameSuggestionSuccessState(success),
        );
      },
    );
  }

  void _handleGetUsernameSuggestionFailureState(Failure failure) {
    if (failure is GetUsernameSuggestionFailure) {
      TwakeSnackBar.show(context, failure.exception.toString(), isError: true);
    } else {
      TwakeSnackBar.show(
        context,
        'Failed to get username suggestion',
        isError: true,
      );
    }
  }

  void _handleGetUsernameSuggestionSuccessState(Success success) {
    if (success is GetUsernameSuggestionSuccess) {
      nameSuggestions.value = success.getUsernameSuggestionResponse.suggestions;
    }
  }

  // Update button enabled state based on valid input
  void _updateButtonState() {
    final nickname = nicknameController.text.trim();
    isButtonEnabledNotifier.value = nickname.length >= 2;
  }

  void handleNicknameInput(String value) {
    setDebouncerValue(value);
    // Clear error when user starts typing
    if (errorMessage != null) {
      setState(() {
        errorMessage = null;
      });
    }
  }

  // Set the text field value to the selected suggestion
  void selectNicknameSuggestion(String suggestion) {
    nicknameController.text = suggestion;
    nicknameFocusNode.requestFocus();
    // Move cursor to end of text
    nicknameController.selection = TextSelection.fromPosition(
      TextPosition(offset: nicknameController.text.length),
    );
  }

  void onTapContinue() {
    final nickname = nicknameController.text.trim();

    if (nickname.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your nickname';
      });
      return;
    }

    if (nickname.length < 2) {
      setState(() {
        errorMessage = 'Nickname must be at least 2 characters';
      });
      return;
    }

    if (widget.args == null) {
      TwakeSnackBar.show(context, 'Failed to set username', isError: true);
      context.pop();
      return;
    }

    // Clear any previous errors
    setState(() {
      errorMessage = null;
    });

    _setUsernameSubscription = _setUsernameInteractor
        .execute(
          SetUsernameRequest(
            username: nickname,
            email: widget.args!.email,
            password: widget.args!.password,
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
    if (failure is SetUsernameFailure) {
      TwakeSnackBar.show(context, failure.exception, isError: true);
    } else {
      TwakeSnackBar.show(context, 'Failed to set username', isError: true);
    }
  }

  void _handleSetUsernameSuccessState(Success success) {
    if (success is SetUsernameSuccess) {
      if (widget.args == null) {
        TwakeSnackBar.show(context, 'Failed to set username', isError: true);
        context.pop();
        return;
      }

      _signinSubscription = _signinInteractor
          .execute(
            email: widget.args!.email,
            password: widget.args!.password,
          )
          .listen(_handleSigninState);
    }
  }

  void _handleSigninState(Either<Failure, Success> state) {
    state.fold(
      (failure) => _handleSigninFailureState(failure),
      (success) => _handleSigninSuccessState(success),
    );
  }

  void _handleSigninFailureState(Failure failure) {
    if (failure is SigninFailure) {
      TwakeSnackBar.show(context, failure.exception.toString(), isError: true);
    } else {
      TwakeSnackBar.show(context, 'Failed to sign in', isError: true);
    }
  }

  Future<void> _handleSigninSuccessState(Success success) async {
    if (success is SigninSuccess) {
      try {
        var homeserver = Uri.parse(AppConfig.sampleValue);
        Logs().d('Homeserver URL: ${homeserver.toString()}');

        if (homeserver.scheme.isEmpty) {
          homeserver = Uri.http(AppConfig.defaultHomeserver, '');
        }

        Logs().d('Homeserver URL: ${homeserver.toString()}');

        final matrix = Matrix.of(context);

        matrix.loginHomeserverSummary =
            await matrix.getLoginClient().checkHomeserver(homeserver);

        Logs().d('Homeserver summary: ${matrix.loginHomeserverSummary}');

        final ssoSupported = matrix.loginHomeserverSummary!.loginFlows
            .any((flow) => flow.type == 'm.login.sso');

        try {
          final test = await matrix.getLoginClient().register(
                username: success.authResponse.username,
                password: widget.args?.password,
              );

          Logs().d('Registration response: $test');
          matrix.loginRegistrationSupported = true;
        } on MatrixException catch (e) {
          matrix.loginRegistrationSupported = e.requireAdditionalAuthentication;
        }

        if (ssoSupported && matrix.loginRegistrationSupported == true) {
          TwakeSnackBar.show(context, 'SSO supported');

          return;
        }

        final AuthenticationIdentifier identifier =
            AuthenticationThirdPartyIdentifier(
          medium: 'email',
          address: widget.args?.email ?? '',
        );

        Matrix.of(context).loginType = LoginType.mLoginPassword;

        await matrix
            .getLoginClient()
            .login(
              LoginType.mLoginPassword,
              identifier: identifier,
              password: widget.args?.password,
              user: success.authResponse.matrixUserId,
              initialDeviceDisplayName: PlatformInfos.clientName,
            )
            .then(
              (onValue) => {
                Logs().d('Login response: $onValue'),
                context.push('/rooms'),
              },
            )
            .catchError(
              (onError) => {
                Logs().e('Login error: $onError'),
              },
            );
      } on MatrixException catch (exception) {
        Logs().e('Login error: $exception');
        setState(() {
          errorMessage = exception.errorMessage;
          isLoading = false;
        });

        return;
      } catch (exception) {
        Logs().e('Exception: $exception');
        setState(() {
          errorMessage = exception.toString();
          isLoading = false;
        });
        return;
      }
    }

    if (mounted) setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) =>
      RegistrationNicknameView(controller: this);
}
