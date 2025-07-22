import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluffychat/data/network/omni_endpoint.dart';
import 'package:matrix/matrix.dart';

class AuthorizationInterceptor extends InterceptorsWrapper {
  static final List<String> omniCustomService = [
    OmniEndpoint.userSearchServicePath.path,
    OmniEndpoint.getContactServicePath.path,
  ];

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
    String? token = _accessToken;

    // Extract just the path part from the full URL
    final String pathOnly;
    if (options.path.startsWith('http')) {
      // If it's a full URL, parse it and extract just the path
      final uri = Uri.parse(options.path);
      pathOnly = uri.path;
    } else {
      // If it's already just a path, use it as is
      pathOnly = options.path;
    }

    if (omniCustomService.contains(pathOnly)) {
      token = _omniAccessToken;
    } else {
      token = _accessToken;
    }

    if (token != null) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      Logs().d(
        'AuthorizationInterceptor::onRequest:accessToken: $token with path: $pathOnly',
      );
    }

    super.onRequest(options, handler);
  }
}
