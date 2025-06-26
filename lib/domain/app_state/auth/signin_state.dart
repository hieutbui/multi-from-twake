import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/initial.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/auth/auth_response.dart';

class SigninInitial extends Initial {
  const SigninInitial() : super();

  @override
  List<Object?> get props => [];
}

class SigninLoading extends Success {
  const SigninLoading();

  @override
  List<Object?> get props => [];
}

class SigninSuccess extends Success {
  final AuthResponse authResponse;

  const SigninSuccess({required this.authResponse});

  @override
  List<Object?> get props => [authResponse];
}

class SigninFailure extends Failure {
  final dynamic exception;

  const SigninFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
