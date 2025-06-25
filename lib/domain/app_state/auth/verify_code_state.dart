import 'package:fluffychat/app_state/initial.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/auth/verify_code_response.dart';

class VerifyCodeInitialState extends Initial {
  const VerifyCodeInitialState() : super();

  @override
  List<Object?> get props => [];
}

class VerifyCodeLoadingState extends Success {
  const VerifyCodeLoadingState() : super();

  @override
  List<Object?> get props => [];
}

class VerifyCodeSuccessState extends Success {
  final VerifyCodeResponse response;

  const VerifyCodeSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class VerifyCodeFailureState extends Failure {
  final dynamic exception;

  const VerifyCodeFailureState({required this.exception});

  @override
  List<Object?> get props => [exception];
}
