import 'package:fluffychat/data/datasource/auth_datasource.dart';
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
import 'package:fluffychat/data/network/auth/omni_auth_api.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final OmniAuthAPI _omniAuthAPI = getIt.get<OmniAuthAPI>();

  @override
  Future<SignupResponse> signup(SignupRequest request) async {
    return await _omniAuthAPI.signup(request);
  }

  @override
  Future<AuthResponse> signin(SigninRequest request) async {
    return await _omniAuthAPI.signin(request);
  }

  @override
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest request) async {
    return await _omniAuthAPI.checkVerificationCode(request);
  }

  @override
  Future<SetDisplayNameResponse> setDisplayName(
    SetDisplayNameRequest request,
  ) async {
    return await _omniAuthAPI.setDisplayName(request);
  }

  @override
  Future<SetUsernameResponse> setUsername(
    SetUsernameRequest request,
  ) async {
    return await _omniAuthAPI.setUsername(request);
  }

  @override
  Future<GetUsernameSuggestionResponse> getUsernameSuggestion(
    GetUsernameSuggestionRequest request,
  ) async {
    return await _omniAuthAPI.getUsernameSuggestion(request);
  }

  @override
  Future<AuthResponse> oauthSignup(OAuthRequest request) async {
    return await _omniAuthAPI.oauthSignup(request);
  }

  @override
  Future<AuthResponse> oauthSignin(OAuthRequest request) async {
    return await _omniAuthAPI.oauthSignin(request);
  }

  @override
  Future<SignoutResponse> signout() async {
    return await _omniAuthAPI.signout();
  }
}
