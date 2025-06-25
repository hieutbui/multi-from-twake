import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/domain/app_state/auth/signin_state.dart';
import 'package:fluffychat/domain/repository/auth_repository.dart';

class OAuthSigninInteractor {
  final AuthRepository _authRepository;

  OAuthSigninInteractor(this._authRepository);

  Stream<Either<Failure, Success>> execute({
    required String idToken,
    required String provider,
  }) async* {
    yield const Right(SigninLoadingState());
    try {
      final response = await _authRepository.oauthSignin(
        idToken: idToken,
        provider: provider,
      );
      yield Right(SigninSuccessState(authResponse: response));
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        yield const Left(
          SigninFailureState(
            exception: 'Invalid provider or token',
          ),
        );
      } else if (error.response?.statusCode == 404) {
        yield const Left(
          SigninFailureState(
            exception: 'User not found',
          ),
        );
      } else {
        yield const Left(
          SigninFailureState(
            exception: 'Failed to sign in. Please try again later.',
          ),
        );
      }
    } catch (error) {
      yield Left(
        SigninFailureState(
          exception: error.toString(),
        ),
      );
    }
  }
}
