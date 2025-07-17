import 'package:fluffychat/data/datasource/search/omni_user_search_datasource.dart';
import 'package:fluffychat/data/model/search/omni_user_search_request.dart';
import 'package:fluffychat/data/model/search/omni_user_search_response.dart';
import 'package:fluffychat/data/network/user/omni_user_api.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';

class OmniUserSearchDatasourceImpl implements OmniUserSearchDatasource {
  final OmniUserApi _omniUserApi = getIt.get<OmniUserApi>();

  @override
  Future<OmniUserSearchResponse> userSearch(
    OmniUserSearchRequest request,
  ) async {
    return await _omniUserApi.userSearch(request);
  }
}
