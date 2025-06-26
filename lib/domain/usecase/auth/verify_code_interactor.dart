import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/auth/verify_code_state.dart';
import 'package:fluffychat/domain/repository/auth_repository.dart';

class VerifyCodeInteractor {
  final AuthRepository _authRepository = getIt.get<AuthRepository>();

  Stream<Either<Failure, Success>> execute({
    required String email,
    required String verificationCode,
  }) async* {
    yield const Right(VerifyCodeLoading());
    try {
      final response = await _authRepository.verifyCode(
        email: email,
        verificationCode: verificationCode,
      );
      yield Right(VerifyCodeSuccess(response: response));
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        yield const Left(
          VerifyCodeFailure(exception: 'Invalid verification code'),
        );
      } else if (error.response?.statusCode == 404) {
        yield const Left(VerifyCodeFailure(exception: 'Email not found'));
      } else if (error.response?.statusCode == 409) {
        yield const Left(
          VerifyCodeFailure(exception: 'Email already verified'),
        );
      } else {
        yield const Left(
          VerifyCodeFailure(exception: 'Failed to verify code'),
        );
      }
    } catch (error) {
      yield Left(
        VerifyCodeFailure(
          exception: error.toString(),
        ),
      );
    }
  }
}
