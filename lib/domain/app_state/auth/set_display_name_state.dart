import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/initial.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/auth/set_display_name_response.dart';

class SetDisplayNameInitial extends Initial {
  const SetDisplayNameInitial() : super();

  @override
  List<Object?> get props => [];
}

class SetDisplayNameLoading extends Success {
  const SetDisplayNameLoading() : super();

  @override
  List<Object?> get props => [];
}

class SetDisplayNameSuccess extends Success {
  final SetDisplayNameResponse setDisplayNameResponse;

  const SetDisplayNameSuccess({required this.setDisplayNameResponse});

  @override
  List<Object?> get props => [setDisplayNameResponse];
}

class SetDisplayNameFailure extends Failure {
  final dynamic exception;

  const SetDisplayNameFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
