import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/auth/signin_state.dart';
import 'package:fluffychat/domain/repository/auth_repository.dart';

class SigninInteractor {
  final AuthRepository _authRepository = getIt.get<AuthRepository>();

  SigninInteractor();

  Stream<Either<Failure, Success>> execute({
    required String email,
    required String password,
  }) async* {
    yield const Right(SigninLoadingState());
    try {
      final authResponse = await _authRepository.signin(
        email: email,
        password: password,
      );
      yield Right(SigninSuccessState(authResponse: authResponse));
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        yield const Left(
          SigninFailureState(exception: 'Invalid email or password format'),
        );
      } else if (error.response?.statusCode == 401) {
        yield const Left(SigninFailureState(exception: 'Invalid credentials'));
      } else if (error.response?.statusCode == 404) {
        yield const Left(SigninFailureState(exception: 'User not found'));
      } else {
        yield const Left(SigninFailureState(exception: 'Failed to sign in'));
      }
    } catch (error) {
      yield Left(SigninFailureState(exception: error.toString()));
    }
  }
}
