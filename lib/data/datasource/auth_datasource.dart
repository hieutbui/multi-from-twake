import 'package:fluffychat/data/model/auth/auth_response.dart';
import 'package:fluffychat/data/model/auth/o_auth_request.dart';
import 'package:fluffychat/data/model/auth/sign_in_request.dart';
import 'package:fluffychat/data/model/auth/sign_out_response.dart';
import 'package:fluffychat/data/model/auth/sign_up_request.dart';
import 'package:fluffychat/data/model/auth/verify_code_request.dart';
import 'package:fluffychat/data/model/auth/verify_code_response.dart';

abstract class AuthDatasource {
  Future<AuthResponse> signup(SignupRequest request);

  Future<AuthResponse> signin(SigninRequest request);

  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest request);

  Future<AuthResponse> oauthSignup(OAuthRequest request);

  Future<AuthResponse> oauthSignin(OAuthRequest request);

  Future<SignoutResponse> signout();
}
