import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/initial.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/auth/sign_up_response.dart';

class SignupInitial extends Initial {
  const SignupInitial() : super();

  @override
  List<Object?> get props => [];
}

class SignupLoading extends Success {
  const SignupLoading() : super();

  @override
  List<Object?> get props => [];
}

class SignupSuccess extends Success {
  final SignupResponse signupResponse;

  const SignupSuccess({required this.signupResponse});

  @override
  List<Object?> get props => [signupResponse];
}

class SignupFailure extends Failure {
  final dynamic exception;

  const SignupFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
