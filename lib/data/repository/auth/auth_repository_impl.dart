import 'package:fluffychat/data/datasource/auth_datasource.dart';
import 'package:fluffychat/data/model/auth/auth_response.dart';
import 'package:fluffychat/data/model/auth/o_auth_request.dart';
import 'package:fluffychat/data/model/auth/sign_in_request.dart';
import 'package:fluffychat/data/model/auth/sign_out_response.dart';
import 'package:fluffychat/data/model/auth/sign_up_request.dart';
import 'package:fluffychat/data/model/auth/sign_up_response.dart';
import 'package:fluffychat/data/model/auth/verify_code_request.dart';
import 'package:fluffychat/data/model/auth/verify_code_response.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource = getIt.get<AuthDatasource>();

  @override
  Future<SignupResponse> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String username,
    required String password,
  }) async {
    final request = SignupRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      username: username,
      password: password,
    );
    return await _authDatasource.signup(request);
  }

  @override
  Future<AuthResponse> signin({
    required String email,
    required String password,
  }) async {
    final request = SigninRequest(
      email: email,
      password: password,
    );
    return await _authDatasource.signin(request);
  }

  @override
  Future<VerifyCodeResponse> verifyCode({
    required String email,
    required String verificationCode,
  }) async {
    final request = VerifyCodeRequest(
      email: email,
      verificationCode: verificationCode,
    );
    return await _authDatasource.verifyCode(request);
  }

  @override
  Future<AuthResponse> oauthSignup({
    required String provider,
    required String idToken,
  }) async {
    final request = OAuthRequest(
      provider: provider,
      idToken: idToken,
    );
    return await _authDatasource.oauthSignup(request);
  }

  @override
  Future<AuthResponse> oauthSignin({
    required String provider,
    required String idToken,
  }) async {
    final request = OAuthRequest(
      provider: provider,
      idToken: idToken,
    );
    return await _authDatasource.oauthSignin(request);
  }

  @override
  Future<SignoutResponse> signout() async {
    return await _authDatasource.signout();
  }
}
