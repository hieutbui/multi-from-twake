import 'package:fluffychat/data/datasource/search/omni_user_search_datasource.dart';
import 'package:fluffychat/data/model/search/omni_user_search_request.dart';
import 'package:fluffychat/data/model/search/omni_user_search_response.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/repository/search/omni_user_search_repository.dart';

class OmniUserSearchRepositoryImpl implements OmniUserSearchRepository {
  final OmniUserSearchDatasource _omniUserSearchDatasource =
      getIt.get<OmniUserSearchDatasource>();

  @override
  Future<OmniUserSearchResponse> userSearch(
    OmniUserSearchRequest request,
  ) async {
    return await _omniUserSearchDatasource.userSearch(request);
  }
}
