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
import 'package:fluffychat/data/network/auth/omni_endpoint.dart';
import 'package:fluffychat/data/network/dio_client.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/di/global/network_di.dart';

class OmniAuthAPI {
  final DioClient _dioClient =
      getIt.get<DioClient>(instanceName: NetworkDI.omniDioClientName);

  OmniAuthAPI();

  Future<SignupResponse> signup(SignupRequest request) async {
    final response = await _dioClient.post(
      OmniEndpoint.signupServicePath.generateOmniEndpoint(),
      data: request.toJson(),
    );
    return SignupResponse.fromJson(response.data);
  }

  Future<AuthResponse> signin(SigninRequest request) async {
    final response = await _dioClient.post(
      OmniEndpoint.signinServicePath.generateOmniEndpoint(),
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response.data);
  }

  Future<VerifyCodeResponse> checkVerificationCode(
    VerifyCodeRequest request,
  ) async {
    final response = await _dioClient.post(
      OmniEndpoint.checkCodeServicePath.generateOmniEndpoint(),
      data: request.toJson(),
    );
    return VerifyCodeResponse.fromJson(response.data);
  }

  Future<SetDisplayNameResponse> setDisplayName(
    SetDisplayNameRequest request,
  ) async {
    final response = await _dioClient.post(
      OmniEndpoint.setDisplayNameServicePath.generateOmniEndpoint(),
      data: request.toJson(),
    );
    return SetDisplayNameResponse.fromJson(response.data);
  }

  Future<SetUsernameResponse> setUsername(
    SetUsernameRequest request,
  ) async {
    final response = await _dioClient.post(
      OmniEndpoint.setUsernameServicePath.generateOmniEndpoint(),
      data: request.toJson(),
    );
    return SetUsernameResponse.fromJson(response.data);
  }

  Future<GetUsernameSuggestionResponse> getUsernameSuggestion(
    GetUsernameSuggestionRequest request,
  ) async {
    final response = await _dioClient.get(
      OmniEndpoint.getUsernameSuggestion.generateOmniEndpoint(),
      queryParameters: {'display_name': request.displayName},
    );
    return GetUsernameSuggestionResponse.fromJson(response);
  }

  Future<AuthResponse> oauthSignup(OAuthRequest request) async {
    final response = await _dioClient.post(
      OmniEndpoint.oauthSignupServicePath.generateOmniEndpoint(),
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> oauthSignin(OAuthRequest request) async {
    final response = await _dioClient.post(
      OmniEndpoint.oauthSigninServicePath.generateOmniEndpoint(),
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response.data);
  }

  Future<SignoutResponse> signout() async {
    final response = await _dioClient.post(
      OmniEndpoint.signoutServicePath.generateOmniEndpoint(),
    );
    return SignoutResponse.fromJson(response.data);
  }
}
