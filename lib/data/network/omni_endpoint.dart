import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/data/network/service_path.dart';

class OmniEndpoint {
  static const apiRoute = '/api';

  static const authRoute = '$apiRoute/auth';

  static const userRoute = '$apiRoute/users';

  static final ServicePath signupServicePath = ServicePath(
    '$authRoute/signup',
  );

  static final ServicePath signinServicePath = ServicePath(
    '$authRoute/signin',
  );

  static final ServicePath checkCodeServicePath = ServicePath(
    '$authRoute/check-code',
  );

  static final ServicePath setDisplayNameServicePath = ServicePath(
    '$authRoute/set-display-name',
  );

  static final ServicePath setUsernameServicePath = ServicePath(
    '$authRoute/set-username',
  );

  static final ServicePath oauthSignupServicePath = ServicePath(
    '$authRoute/oauth/signup',
  );

  static final ServicePath oauthSigninServicePath = ServicePath(
    '$authRoute/oauth/signin',
  );

  static final ServicePath signoutServicePath = ServicePath(
    '$authRoute/signout',
  );

  static final ServicePath getUsernameSuggestion = ServicePath(
    '$authRoute/suggest-usernames',
  );

  static final ServicePath userSearchServicePath = ServicePath(
    '$userRoute/search',
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
