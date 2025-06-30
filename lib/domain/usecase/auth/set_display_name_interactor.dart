import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/auth/set_display_name_request.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/auth/set_display_name_state.dart';
import 'package:fluffychat/domain/repository/auth_repository.dart';

class SetDisplayNameInteractor {
  final AuthRepository _authRepository = getIt.get<AuthRepository>();

  Stream<Either<Failure, Success>> execute(
    SetDisplayNameRequest request,
  ) async* {
    try {
      yield const Right(SetDisplayNameLoading());

      final setDisplayNameResponse =
          await _authRepository.setDisplayName(request);
      yield Right(
        SetDisplayNameSuccess(
          setDisplayNameResponse: setDisplayNameResponse,
        ),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        yield Left(
          SetDisplayNameFailure(
            exception: e.response?.data['detail'] ?? 'Missing required fields',
          ),
        );
      } else if (e.response?.statusCode == 401) {
        yield Left(
          SetDisplayNameFailure(
            exception: e.response?.data['detail'] ?? 'Invalid credentials',
          ),
        );
      } else if (e.response?.statusCode == 404) {
        yield Left(
          SetDisplayNameFailure(
            exception: e.response?.data['detail'] ?? 'User not found',
          ),
        );
      } else {
        yield Left(
          SetDisplayNameFailure(
            exception: e,
          ),
        );
      }
    } catch (e) {
      yield Left(
        SetDisplayNameFailure(
          exception: e,
        ),
      );
    }
  }
}
