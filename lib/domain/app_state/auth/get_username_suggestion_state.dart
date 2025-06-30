import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/initial.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/auth/get_username_suggestion_response.dart';

class GetUsernameSuggestionInitial extends Initial {
  const GetUsernameSuggestionInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetUsernameSuggestionLoading extends Success {
  const GetUsernameSuggestionLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetUsernameSuggestionSuccess extends Success {
  final GetUsernameSuggestionResponse getUsernameSuggestionResponse;

  const GetUsernameSuggestionSuccess({
    required this.getUsernameSuggestionResponse,
  });

  @override
  List<Object?> get props => [getUsernameSuggestionResponse];
}

class GetUsernameSuggestionFailure extends Failure {
  final dynamic exception;

  const GetUsernameSuggestionFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
