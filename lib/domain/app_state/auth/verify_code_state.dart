import 'package:fluffychat/app_state/initial.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/auth/verify_code_response.dart';

class VerifyCodeInitial extends Initial {
  const VerifyCodeInitial() : super();

  @override
  List<Object?> get props => [];
}

class VerifyCodeLoading extends Success {
  const VerifyCodeLoading() : super();

  @override
  List<Object?> get props => [];
}

class VerifyCodeSuccess extends Success {
  final VerifyCodeResponse response;

  const VerifyCodeSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class VerifyCodeFailure extends Failure {
  final dynamic exception;

  const VerifyCodeFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
