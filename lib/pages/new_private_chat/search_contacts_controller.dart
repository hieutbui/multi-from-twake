import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/contact/get_contacts_success.dart';
import 'package:fluffychat/domain/model/contact/contact_query.dart';
import 'package:fluffychat/domain/usecase/lookup_contacts_interactor.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class SearchContactsController {
  static const debouncerIntervalInMilliseconds = 400;

  final LookupContactsInteractor _lookupNetworkContactsInteractor = getIt.get<LookupContactsInteractor>();
  late final Debouncer<String> _debouncer;
  final TextEditingController textEditingController = TextEditingController();
  StreamController<Either<Failure, GetContactsSuccess>> lookupStreamController = StreamController();
  void Function(String)? onSearchKeywordChanged;

  String searchKeyword = "";

  void init() {
    _initializeDebouncer();
    textEditingController.addListener(() {
      onSearchBarChanged(textEditingController.text);
      if (onSearchKeywordChanged != null) {
        onSearchKeywordChanged!(textEditingController.text);
      }
    });
  }

  void _initializeDebouncer() {
    _debouncer = Debouncer(
      const Duration(milliseconds: debouncerIntervalInMilliseconds), 
      initialValue: '',
    );

    _debouncer.values.listen((keyword) async {
      Logs().d("SearchContactsController::_initializeDebouncer: searchKeyword: $searchKeyword");
      searchKeyword = keyword;
      fetchLookupContacts();
    });
  }

  void fetchLookupContacts() {
    _lookupNetworkContactsInteractor
      .execute(query: ContactQuery(keyword: searchKeyword)).listen((event) {
        lookupStreamController.add(event);
      });
  }

  void onSearchBarChanged(String keyword) {
    _debouncer.setValue(keyword);
    searchKeyword = keyword;
  }

  void dispose() {
    _debouncer.cancel();
    textEditingController.dispose();
    lookupStreamController.close();
  }
}