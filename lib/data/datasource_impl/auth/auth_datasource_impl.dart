import 'package:fluffychat/data/datasource/auth_datasource.dart';
import 'package:fluffychat/data/model/auth/auth_response.dart';
import 'package:fluffychat/data/model/auth/o_auth_request.dart';
import 'package:fluffychat/data/model/auth/sign_in_request.dart';
import 'package:fluffychat/data/model/auth/sign_out_response.dart';
import 'package:fluffychat/data/model/auth/sign_up_request.dart';
import 'package:fluffychat/data/model/auth/verify_code_request.dart';
import 'package:fluffychat/data/model/auth/verify_code_response.dart';
import 'package:fluffychat/data/network/auth/omni_auth_api.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final OmniAuthAPI _omniAuthAPI = getIt.get<OmniAuthAPI>();

  @override
  Future<AuthResponse> signup(SignupRequest request) async {
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
