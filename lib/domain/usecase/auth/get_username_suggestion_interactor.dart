import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/auth/get_username_suggestion_request.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/auth/get_username_suggestion_state.dart';
import 'package:fluffychat/domain/repository/auth_repository.dart';

class GetUsernameSuggestionInteractor {
  final AuthRepository _authRepository = getIt.get<AuthRepository>();

  Stream<Either<Failure, Success>> execute(
    GetUsernameSuggestionRequest request,
  ) async* {
    try {
      yield const Right(GetUsernameSuggestionLoading());

      final getUsernameSuggestionResponse =
          await _authRepository.getUsernameSuggestion(request);
      yield Right(
        GetUsernameSuggestionSuccess(
          getUsernameSuggestionResponse: getUsernameSuggestionResponse,
        ),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        yield Left(
          GetUsernameSuggestionFailure(
            exception: e.response?.data['detail'] ?? 'Display name is required',
          ),
        );
      } else {
        yield Left(
          GetUsernameSuggestionFailure(
            exception: e,
          ),
        );
      }
    } catch (e) {
      yield Left(
        GetUsernameSuggestionFailure(
          exception: e,
        ),
      );
    }
  }
}
