import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/search/omni_user_search_request.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/user/omni_user_search_state.dart';
import 'package:fluffychat/domain/repository/search/omni_user_search_repository.dart';

class OmniUserSearchInteractor {
  final OmniUserSearchRepository _omniUserSearchRepository =
      getIt.get<OmniUserSearchRepository>();

  OmniUserSearchInteractor();

  Stream<Either<Failure, Success>> execute(
    OmniUserSearchRequest request,
  ) async* {
    yield const Right(OmniUserSearchLoading());

    try {
      final omniUserSearchResponse =
          await _omniUserSearchRepository.userSearch(request);

      yield Right(
        OmniUserSearchSuccess(omniUserSearchResponse: omniUserSearchResponse),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        yield const Left(
          OmniUserSearchFailure(exception: 'Invalid search query'),
        );
      } else {
        yield const Left(
          OmniUserSearchFailure(exception: 'Failed to search users'),
        );
      }
    } catch (error) {
      yield Left(OmniUserSearchFailure(exception: error.toString()));
    }
  }
}
