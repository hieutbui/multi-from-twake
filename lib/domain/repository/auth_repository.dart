import 'package:fluffychat/data/model/auth/auth_response.dart';
import 'package:fluffychat/data/model/auth/get_username_suggestion_request.dart';
import 'package:fluffychat/data/model/auth/get_username_suggestion_response.dart';
import 'package:fluffychat/data/model/auth/set_display_name_request.dart';
import 'package:fluffychat/data/model/auth/set_display_name_response.dart';
import 'package:fluffychat/data/model/auth/set_username_request.dart';
import 'package:fluffychat/data/model/auth/set_username_response.dart';
import 'package:fluffychat/data/model/auth/sign_out_response.dart';
import 'package:fluffychat/data/model/auth/sign_up_response.dart';
import 'package:fluffychat/data/model/auth/verify_code_response.dart';

abstract class AuthRepository {
  Future<SignupResponse> signup({
    required String email,
    required String password,
  });

  Future<AuthResponse> signin({
    required String email,
    required String password,
  });

  Future<VerifyCodeResponse> verifyCode({
    required String email,
    required String verificationCode,
  });

  Future<SetDisplayNameResponse> setDisplayName(SetDisplayNameRequest request);

  Future<SetUsernameResponse> setUsername(SetUsernameRequest request);

  Future<GetUsernameSuggestionResponse> getUsernameSuggestion(
    GetUsernameSuggestionRequest request,
  );

  Future<AuthResponse> oauthSignup({
    required String provider,
    required String idToken,
  });

  Future<AuthResponse> oauthSignin({
    required String provider,
    required String idToken,
  });

  Future<SignoutResponse> signout();
}
