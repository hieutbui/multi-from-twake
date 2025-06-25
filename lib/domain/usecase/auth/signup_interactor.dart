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
    required String firstName,
    required String lastName,
    required String username,
  }) async* {
    try {
      yield const Right(SignupLoadingState());

      final authResponse = await _authRepository.signup(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        username: username,
      );

      yield Right(SignupSuccessState(authResponse: authResponse));
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        yield const Left(
          SignupFailureState(exception: 'Invalid email or password format'),
        );
      } else if (e.response?.statusCode == 409) {
        yield const Left(SignupFailureState(exception: 'Email already exists'));
      } else {
        yield const Left(
          SignupFailureState(exception: 'An error occurred during signup'),
        );
      }
    } catch (e) {
      yield Left(SignupFailureState(exception: e.toString()));
    }
  }
}
