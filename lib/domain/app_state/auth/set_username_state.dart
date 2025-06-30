import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/initial.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/auth/set_username_response.dart';

class SetUsernameInitial extends Initial {
  const SetUsernameInitial() : super();

  @override
  List<Object?> get props => [];
}

class SetUsernameLoading extends Success {
  const SetUsernameLoading() : super();

  @override
  List<Object?> get props => [];
}

class SetUsernameSuccess extends Success {
  final SetUsernameResponse setUsernameResponse;

  const SetUsernameSuccess({required this.setUsernameResponse});

  @override
  List<Object?> get props => [setUsernameResponse];
}

class SetUsernameFailure extends Failure {
  final dynamic exception;

  const SetUsernameFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
