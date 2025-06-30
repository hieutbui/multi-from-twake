import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/auth/signup_state.dart';
import 'package:fluffychat/domain/repository/auth_repository.dart';

class SignupInteractor {
  final AuthRepository _authRepository = getIt.get<AuthRepository>();

  Stream<Either<Failure, Success>> execute({
    required String email,
    required String password,
  }) async* {
    try {
      yield const Right(SignupLoading());

      final signupResponse = await _authRepository.signup(
        email: email,
        password: password,
      );
      yield Right(SignupSuccess(signupResponse: signupResponse));
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        yield Left(
          SignupFailure(
            exception: e.response?.data['detail'] ?? 'Email already registered',
          ),
        );
      } else if (e.response?.statusCode == 500) {
        yield const Left(SignupFailure(exception: 'Failed to sign up'));
      } else {
        yield Left(
          SignupFailure(exception: e),
        );
      }
    } catch (e) {
      yield Left(SignupFailure(exception: e));
    }
  }
}
