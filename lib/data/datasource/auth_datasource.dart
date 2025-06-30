import 'package:fluffychat/data/model/auth/auth_response.dart';
import 'package:fluffychat/data/model/auth/get_username_suggestion_request.dart';
import 'package:fluffychat/data/model/auth/get_username_suggestion_response.dart';
import 'package:fluffychat/data/model/auth/o_auth_request.dart';
import 'package:fluffychat/data/model/auth/set_display_name_request.dart';
import 'package:fluffychat/data/model/auth/set_display_name_response.dart';
import 'package:fluffychat/data/model/auth/set_username_request.dart';
import 'package:fluffychat/data/model/auth/set_username_response.dart';
import 'package:fluffychat/data/model/auth/sign_in_request.dart';
import 'package:fluffychat/data/model/auth/sign_out_response.dart';
import 'package:fluffychat/data/model/auth/sign_up_request.dart';
import 'package:fluffychat/data/model/auth/sign_up_response.dart';
import 'package:fluffychat/data/model/auth/verify_code_request.dart';
import 'package:fluffychat/data/model/auth/verify_code_response.dart';

abstract class AuthDatasource {
  Future<SignupResponse> signup(SignupRequest request);

  Future<AuthResponse> signin(SigninRequest request);

  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest request);

  Future<SetDisplayNameResponse> setDisplayName(SetDisplayNameRequest request);

  Future<SetUsernameResponse> setUsername(SetUsernameRequest request);

  Future<GetUsernameSuggestionResponse> getUsernameSuggestion(
    GetUsernameSuggestionRequest request,
  );

  Future<AuthResponse> oauthSignup(OAuthRequest request);

  Future<AuthResponse> oauthSignin(OAuthRequest request);

  Future<SignoutResponse> signout();
}
