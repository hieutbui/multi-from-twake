import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/initial.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/search/omni_user_search_response.dart';

class OmniUserSearchInitial extends Initial {
  const OmniUserSearchInitial() : super();

  @override
  List<Object?> get props => [];
}

class OmniUserSearchLoading extends Success {
  const OmniUserSearchLoading() : super();

  @override
  List<Object?> get props => [];
}

class OmniUserSearchSuccess extends Success {
  final OmniUserSearchResponse omniUserSearchResponse;

  const OmniUserSearchSuccess({required this.omniUserSearchResponse});

  @override
  List<Object?> get props => [omniUserSearchResponse];
}

class OmniUserSearchFailure extends Failure {
  final dynamic exception;

  const OmniUserSearchFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
