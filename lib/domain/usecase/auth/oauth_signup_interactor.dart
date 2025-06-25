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
    yield const Right(SignupLoadingState());
    try {
      final response = await _authRepository.oauthSignup(
        provider: provider,
        idToken: idToken,
      );
      yield Right(SignupSuccessState(authResponse: response));
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        yield const Left(SignupFailureState(exception: 'Invalid token'));
      } else {
        yield const Left(
          SignupFailureState(
            exception: 'Failed to sign up. Please try again later.',
          ),
        );
      }
    } catch (error) {
      yield Left(SignupFailureState(exception: error.toString()));
    }
  }
}
