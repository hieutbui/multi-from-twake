import 'dart:convert';

import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/pages/auto_homeserver_picker/auto_homeserver_picker.dart';
import 'package:fluffychat/pages/connect/connect_page.dart';
import 'package:fluffychat/utils/dialog/twake_dialog.dart';
import 'package:fluffychat/utils/exception/homeserver_exception.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

import 'package:matrix/matrix.dart';
import 'package:universal_html/html.dart' as html;

typedef OnSAASRegistrationTimeoutCallback = void Function();
typedef OnSAASRegistrationErrorCallback = void Function(Object?);

mixin ConnectPageMixin {
  static const saasRegistrationTimeout = Duration(seconds: 120);

  static const windowNameValue = '_self';

  static const redirectPublicPlatformOnWeb = 'post_login_redirect_url';

  bool supportsFlow({
    required BuildContext context,
    required String flowType,
  }) =>
      Matrix.of(context)
          .loginHomeserverSummary
          ?.loginFlows
          .any((flow) => flow.type == flowType) ??
      false;

  bool supportsSso(BuildContext context) =>
      (PlatformInfos.isMobile ||
          PlatformInfos.isWeb ||
          PlatformInfos.isMacOS) &&
      supportsFlow(context: context, flowType: 'm.login.sso');

  bool supportsLogin(BuildContext context) =>
      supportsFlow(context: context, flowType: 'm.login.password');

  String _getRedirectUrlScheme(String redirectUrl) {
    return Uri.parse(redirectUrl).scheme;
  }

  String _getAuthenticateUrl({
    required BuildContext context,
    required String id,
    required String redirectUrl,
  }) {
    final homeserver =
        Matrix.of(context).getLoginClient().homeserver?.toString();
    final ssoRedirectUri =
        '$homeserver/_matrix/client/r0/login/sso/redirect/${Uri.encodeComponent(id)}';
    final redirectUrlEncode = Uri.encodeQueryComponent(redirectUrl);
    return '$ssoRedirectUri?redirectUrl=$redirectUrlEncode';
  }

  String generatePublicPlatformAuthenticationUrl({
    required BuildContext context,
    required String id,
    required String redirectUrl,
  }) {
    final redirectUrlEncode = Uri.encodeQueryComponent(redirectUrl);
    return '${AppConfig.registrationUrl}?$redirectPublicPlatformOnWeb=$redirectUrlEncode';
  }

  String? _getLogoutUrl(
    BuildContext context, {
    required String redirectUrl,
  }) {
    final authUrl = Matrix.of(context).authUrl;
    if (authUrl == null) return null;
    final redirectUrlEncode = base64Url.encode(utf8.encode(redirectUrl));
    return '$authUrl?logout=1&url=$redirectUrlEncode';
  }

  Future<String> authenticateWithWebAuth({
    required BuildContext context,
    required String id,
  }) async {
    final redirectUrl = _generateRedirectUrl(
      Matrix.of(context).client.homeserver.toString(),
    );
    final url = _getAuthenticateUrl(
      context: context,
      id: id,
      redirectUrl: redirectUrl,
    );
    final urlScheme = _getRedirectUrlScheme(redirectUrl);
    return await FlutterWebAuth2.authenticate(
      url: url,
      callbackUrlScheme: urlScheme,
      options: const FlutterWebAuth2Options(
        intentFlags: ephemeralIntentFlags,
        windowName: windowNameValue,
      ),
    );
  }

  Future<void> ssoLoginAction({
    required BuildContext context,
    required String id,
  }) async {
    if (PlatformInfos.isWeb) {
      await ssoLoginActionWeb(context: context, id: id);
    } else {
      ssoLoginActionMobile(context: context, id: id);
    }
  }

  Future<void> ssoLoginActionWeb({
    required BuildContext context,
    required String id,
  }) async {
    await authenticateWithWebAuth(context: context, id: id);
  }

  void ssoLoginActionMobile({
    required BuildContext context,
    required String id,
  }) async {
    final result = await authenticateWithWebAuth(context: context, id: id);
    final token = Uri.parse(result).queryParameters['loginToken'];
    if (token?.isEmpty ?? false) return;
    Matrix.of(context).loginType = LoginType.mLoginToken;
    await TwakeDialog.showFutureLoadingDialogFullScreen(
      future: () => Matrix.of(context)
          .getLoginClient()
          .login(
            LoginType.mLoginToken,
            token: token,
            initialDeviceDisplayName: PlatformInfos.clientName,
          )
          .timeout(
        AutoHomeserverPickerController.autoHomeserverPickerTimeout,
        onTimeout: () {
          throw CheckHomeserverTimeoutException();
        },
      ),
    );
  }

  Future<void> tryLogoutSso(BuildContext context) async {
    if (Matrix.of(context).loginType != LoginType.mLoginToken) return;
    final redirectUrl = _generatePostLogoutRedirectUrl();
    final url = _getLogoutUrl(context, redirectUrl: redirectUrl);
    if (url == null) return Future.value();

    final urlScheme = _getRedirectUrlScheme(redirectUrl);
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: url,
        callbackUrlScheme: urlScheme,
        options: const FlutterWebAuth2Options(
          windowName: windowNameValue,
        ),
      );
      Logs().d('tryLogoutSso::result: $result');
    } catch (e) {
      Logs().d('tryLogoutSso::error: $e');
    }
  }

  Future<void> registerPublicPlatformAction({
    required BuildContext context,
    required String id,
  }) async {
    final redirectUrl = _generateRedirectUrl(
      Matrix.of(context).client.homeserver.toString(),
    );
    final url = generatePublicPlatformAuthenticationUrl(
      context: context,
      id: id,
      redirectUrl: redirectUrl,
    );
    final urlScheme = _getRedirectUrlScheme(redirectUrl);
    final uri = await FlutterWebAuth2.authenticate(
      url: url,
      callbackUrlScheme: urlScheme,
      options: const FlutterWebAuth2Options(
        intentFlags: ephemeralIntentFlags,
        windowName: windowNameValue,
      ),
    );
    Logs().d("ConnectPageMixin:_redirectRegistrationUrl: URI - $uri");
    final token = Uri.parse(uri).queryParameters['loginToken'];
    if (token == null) {
      throw HomeserverTokenNotFoundException(
        error: L10n.of(context)!.tokenNotFound,
      );
    }
    handleTokenFromRegistrationSite(
      matrix: Matrix.of(context),
      token: token,
    );
  }

  String _generatePostLogoutRedirectUrl() {
    if (kIsWeb) {
      if (AppConfig.issueId != null && AppConfig.issueId!.isNotEmpty) {
        return '${html.window.origin!}/twake-on-matrix/${AppConfig.issueId}/auth.html';
      }
      return '${html.window.origin!}/web/auth.html';
    }
    return '${AppConfig.appOpenUrlScheme.toLowerCase()}://redirect';
  }

  String _generateRedirectUrl(String homeserver) {
    if (kIsWeb) {
      String? homeserverParam = '';
      if (homeserver.isNotEmpty) {
        homeserverParam = '?homeserver=$homeserver';
      }
      if (AppConfig.issueId != null && AppConfig.issueId!.isNotEmpty) {
        return '${html.window.origin!}/twake-on-matrix/${AppConfig.issueId}/auth.html$homeserverParam';
      }
      return '${html.window.origin!}/web/auth.html$homeserverParam';
    }
    return '${AppConfig.appOpenUrlScheme.toLowerCase()}://login';
  }

  List<IdentityProvider>? identityProviders({
    Map<String, dynamic>? rawLoginTypes,
  }) {
    final loginTypes = rawLoginTypes;
    if (loginTypes == null) return null;
    final rawProviders = loginTypes.tryGetList('flows')!.singleWhere(
          (flow) => flow['type'] == AuthenticationTypes.sso,
        )['identity_providers'];
    final list = (rawProviders as List)
        .map((json) => IdentityProvider.fromJson(json))
        .toList();
    if (PlatformInfos.isCupertinoStyle) {
      list.sort((a, b) => a.brand == 'apple' ? -1 : 1);
    }
    return list;
  }

  void handleTokenFromRegistrationSite({
    required MatrixState matrix,
    required String? token,
  }) async {
    Logs().d(
      "ConnectPageMixin: handleTokenFromRegistrationSite: token: $token",
    );
    if (token == null || token.isEmpty == true) return;
    matrix.loginType = LoginType.mLoginToken;
    await TwakeDialog.showFutureLoadingDialogFullScreen(
      future: () => matrix.getLoginClient().login(
            LoginType.mLoginToken,
            token: token,
            initialDeviceDisplayName: PlatformInfos.clientName,
          ),
    );
  }
}
