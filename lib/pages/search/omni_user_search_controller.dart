import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/search/omni_user_search_request.dart';
import 'package:fluffychat/data/network/interceptor/authorization_interceptor.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/user/omni_user_search_state.dart';
import 'package:fluffychat/domain/auth_manager/auth_credential_storage.dart';
import 'package:fluffychat/domain/usecase/user/omni_user_search_interactor.dart';
import 'package:fluffychat/pages/search/search_debouncer_mixin.dart';
import 'package:fluffychat/presentation/model/search/presentation_search.dart';
import 'package:fluffychat/utils/extension/value_notifier_extension.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class OmniUserSearchController with SearchDebouncerMixin {
  OmniUserSearchController();

  static const int _limitOmniUserSearch = 10;

  final OmniUserSearchInteractor _omniUserSearchInteractor =
      getIt.get<OmniUserSearchInteractor>();

  final omniUserSearchNotifier =
      ValueNotifier<List<OmniUserPresentationSearch>>([]);

  final isShowOmniUserSearchNotifier = ValueNotifier(false);

  StreamSubscription<Either<Failure, Success>>? _omniUserSearchSubscription;

  String? _accessToken;

  void toggleShowMore() {
    isShowOmniUserSearchNotifier.toggle();
  }

  Future<void> init() async {
    await _setAccessTokenFromHive();

    initializeDebouncer((keyword) {
      _searchOmniUser(keyword: keyword);
    });
  }

  Future<void> _setAccessTokenFromHive() async {
    try {
      final authStorage = AuthCredentialStorage();
      _accessToken = await authStorage.getOmniAccessToken();

      final AuthorizationInterceptor authorization =
          getIt.get<AuthorizationInterceptor>();
      authorization.omniAccessToken = _accessToken;

      //TODO: Re-get access token from backend
      if (_accessToken == null) {
        Logs().w(
          'OmniUserSearchController: No Omni access token found in storage',
        );
      } else {
        Logs().d(
          'OmniUserSearchController: Retrieved Omni access token from storage',
        );
      }
    } catch (e) {
      Logs().e('OmniUserSearchController: Error retrieving access token: $e');
    }
  }

  void _searchOmniUser({required String keyword}) {
    if (keyword.isEmpty) return;

    //TODO: Get access token
    if (_accessToken == null || _accessToken!.isEmpty) return;

    _omniUserSearchSubscription = _omniUserSearchInteractor
        .execute(
      OmniUserSearchRequest(
        searchTerm: keyword,
        limit: _limitOmniUserSearch,
      ),
    )
        .listen((event) {
      event.map((success) {
        if (success is OmniUserSearchSuccess) {
          final searchResults = success.omniUserSearchResponse.users;

          omniUserSearchNotifier.value =
              searchResults.map((user) => user.toPresentation()).toList();
        }
      });
    });
  }

  void onSearchBarChanged(String keyword) {
    setDebouncerValue(keyword);
  }

  void dispose() {
    disposeDebouncer();
    _omniUserSearchSubscription?.cancel();
    omniUserSearchNotifier.dispose();
  }
}
