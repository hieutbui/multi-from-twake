import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/initial.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/auth/auth_response.dart';

class SigninInitialState extends Initial {
  const SigninInitialState() : super();

  @override
  List<Object?> get props => [];
}

class SigninLoadingState extends Success {
  const SigninLoadingState();

  @override
  List<Object?> get props => [];
}

class SigninSuccessState extends Success {
  final AuthResponse authResponse;

  const SigninSuccessState({required this.authResponse});

  @override
  List<Object?> get props => [authResponse];
}

class SigninFailureState extends Failure {
  final dynamic exception;

  const SigninFailureState({required this.exception});

  @override
  List<Object?> get props => [exception];
}
