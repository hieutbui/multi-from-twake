import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/data/network/service_path.dart';

class OmniEndpoint {
  static final ServicePath signupServicePath = ServicePath(
    '/api/auth/signup',
  );

  static final ServicePath signinServicePath = ServicePath(
    '/api/auth/signin',
  );

  static final ServicePath checkCodeServicePath = ServicePath(
    '/api/auth/check-code',
  );

  static final ServicePath oauthSignupServicePath = ServicePath(
    '/api/auth/oauth/signup',
  );

  static final ServicePath oauthSigninServicePath = ServicePath(
    '/api/auth/oauth/signin',
  );

  static final ServicePath signoutServicePath = ServicePath(
    '/api/auth/signout',
  );

  static const String omniRootPath = '';

  static const String omniAPIVersion = '';
}

extension ServicePathOmni on ServicePath {
  String generateOmniEndpoint({
    String? baseUrl,
  }) {
    final url = baseUrl ?? AppConfig.omniBackendUrl;
    return '$url$path';
  }
}
