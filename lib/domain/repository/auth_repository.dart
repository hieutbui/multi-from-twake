import 'package:fluffychat/data/model/auth/auth_response.dart';
import 'package:fluffychat/data/model/auth/sign_out_response.dart';
import 'package:fluffychat/data/model/auth/sign_up_response.dart';
import 'package:fluffychat/data/model/auth/verify_code_response.dart';

abstract class AuthRepository {
  Future<SignupResponse> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String username,
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
