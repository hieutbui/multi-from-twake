import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/auth/signup_state.dart';
import 'package:fluffychat/domain/repository/auth_repository.dart';

class OAuthSignupInteractor {
  final AuthRepository _authRepository = getIt.get<AuthRepository>();

  Stream<Either<Failure, Success>> execute({
    required String provider,
    required String idToken,
  }) async* {
    yield const Right(SignupLoading());
    try {
      final response = await _authRepository.oauthSignup(
        provider: provider,
        idToken: idToken,
      );
      yield Right(SignupSuccess(authResponse: response));
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        yield const Left(SignupFailure(exception: 'Invalid token'));
      } else {
        yield const Left(
          SignupFailure(
            exception: 'Failed to sign up. Please try again later.',
          ),
        );
      }
    } catch (error) {
      yield Left(SignupFailure(exception: error.toString()));
    }
  }
}
