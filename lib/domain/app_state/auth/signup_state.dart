import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/initial.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/auth/auth_response.dart';

class SignupInitialState extends Initial {
  const SignupInitialState() : super();

  @override
  List<Object?> get props => [];
}

class SignupLoadingState extends Success {
  const SignupLoadingState() : super();

  @override
  List<Object?> get props => [];
}

class SignupSuccessState extends Success {
  final AuthResponse authResponse;

  const SignupSuccessState({required this.authResponse});

  @override
  List<Object?> get props => [authResponse];
}

class SignupFailureState extends Failure {
  final dynamic exception;

  const SignupFailureState({required this.exception});

  @override
  List<Object?> get props => [exception];
}
