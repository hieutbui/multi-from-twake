import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluffychat/data/network/omni_endpoint.dart';
import 'package:matrix/matrix.dart';

class AuthorizationInterceptor extends InterceptorsWrapper {
  AuthorizationInterceptor();

  String? _accessToken;
  String? _omniAccessToken;

  set accessToken(String? accessToken) {
    _accessToken = accessToken;
  }

  set omniAccessToken(String? omniAccessToken) {
    _omniAccessToken = omniAccessToken;
  }

  String? get getAccessToken => _accessToken;
  String? get getOmniAccessToken => _omniAccessToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? token;

    if (options.path.contains(OmniEndpoint.userSearchServicePath.path)) {
      token = 'Bearer $_omniAccessToken';
    } else {
      token = _accessToken;
    }

    if (token != null) {
      options.headers[HttpHeaders.authorizationHeader] = token;
      Logs().d('AuthorizationInterceptor::onRequest:accessToken: $token');
    }

    super.onRequest(options, handler);
  }
}
