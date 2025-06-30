import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/auth/set_username_request.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/auth/set_username_state.dart';
import 'package:fluffychat/domain/repository/auth_repository.dart';

class SetUsernameInteractor {
  final AuthRepository _authRepository = getIt.get<AuthRepository>();

  Stream<Either<Failure, Success>> execute(
    SetUsernameRequest request,
  ) async* {
    try {
      yield const Right(SetUsernameLoading());

      final setUsernameResponse = await _authRepository.setUsername(request);
      yield Right(SetUsernameSuccess(setUsernameResponse: setUsernameResponse));
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        yield Left(
          SetUsernameFailure(
            exception: e.response?.data['detail'] ??
                'Username already taken or invalid format',
          ),
        );
      } else if (e.response?.statusCode == 401) {
        yield Left(
          SetUsernameFailure(
            exception: e.response?.data['detail'] ?? 'Invalid credentials',
          ),
        );
      } else if (e.response?.statusCode == 404) {
        yield Left(
          SetUsernameFailure(
            exception: e.response?.data['detail'] ?? 'User not found',
          ),
        );
      } else if (e.response?.statusCode == 500) {
        yield Left(
          SetUsernameFailure(
            exception:
                e.response?.data['detail'] ?? 'Matrix account creation failed',
          ),
        );
      } else {
        yield Left(
          SetUsernameFailure(
            exception: e,
          ),
        );
      }
    } catch (e) {
      yield Left(
        SetUsernameFailure(
          exception: e,
        ),
      );
    }
  }
}
