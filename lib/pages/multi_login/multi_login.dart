import 'dart:async';

import 'package:dartz/dartz.dart' hide State;
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/auth/signin_state.dart';
import 'package:fluffychat/domain/auth_manager/auth_credential_storage.dart';
import 'package:fluffychat/domain/usecase/auth/signin_interactor.dart';
import 'package:fluffychat/pages/multi_login/multi_login_view.dart';
import 'package:fluffychat/utils/dialog/twake_dialog.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:fluffychat/utils/twake_snackbar.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:matrix/matrix.dart';

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

  // ValueNotifiers for UI state
  final ValueNotifier<bool> isButtonEnabledNotifier =
      ValueNotifier<bool>(false);
  final ValueNotifier<Either<Failure, Success>> signinNotifier =
      ValueNotifier<Either<Failure, Success>>(
    const Right(SigninInitial()),
  );

  // UI state
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    // Listen to text changes to update button state
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _signinSubscription?.cancel();
    emailController.removeListener(_updateButtonState);
    passwordController.removeListener(_updateButtonState);
    emailFocusNode.dispose();
    registrationFormKey.currentState?.dispose();
    emailFieldKey.currentState?.dispose();
    passwordFieldKey.currentState?.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.removeListener(() {});
    passwordFocusNode.removeListener(() {});
    emailController.dispose();
    passwordController.dispose();
    _signinSubscription?.cancel();
    isButtonEnabledNotifier.dispose();
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

  Future<void> onTapContinue() async {
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

    // Update the signin notifier to indicate loading
    signinNotifier.value = const Right(SigninLoading());

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
  void _handleSigninState(Either<Failure, Success> state) {
    signinNotifier.value = state;
    state.fold(
      (failure) => _handleSigninFailureState(failure),
      (success) => _handleSigninSuccessState(success),
    );
  }

  void _handleSigninFailureState(Failure failure) {
    if (failure is SigninFailure) {
      TwakeSnackBar.show(context, failure.exception, isError: true);
    } else {
      TwakeSnackBar.show(context, 'Failed to sign in', isError: true);
    }
  }

  Future<void> _handleSigninSuccessState(Success success) async {
    if (success is SigninSuccess) {
      try {
        final authCredentialStorage = AuthCredentialStorage();
        final accessToken = success.authResponse.accessToken;

        await authCredentialStorage.saveOmniAccessToken(accessToken);

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
                password: passwordController.text,
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
          address: emailController.text,
        );

        Matrix.of(context).loginType = LoginType.mLoginPassword;

        await TwakeDialog.showStreamDialogFullScreen(
          future: () => matrix.getLoginClient().login(
                LoginType.mLoginPassword,
                identifier: identifier,
                password: passwordController.text,
                user: success.authResponse.matrixUserId,
                initialDeviceDisplayName: PlatformInfos.clientName,
              ),
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

      if (mounted) setState(() => isLoading = false);
    }
  }

  void onTapForgotPassword() {
    context.push('/home/forgotPassword');
  }

  // Update button enabled state based on valid input
  void _updateButtonState() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final String? errorPasswordMessage = FormBuilderValidators.compose([
      FormBuilderValidators.password(
        maxLength: 99,
        errorText: 'Your password is not strong enough',
      ),
    ])(passwordController.text.trim());
    isButtonEnabledNotifier.value = email.isNotEmpty &&
        password.isNotEmpty &&
        (errorPasswordMessage == null);
  }

  @override
  Widget build(BuildContext context) => MultiLoginView(controller: this);
}
