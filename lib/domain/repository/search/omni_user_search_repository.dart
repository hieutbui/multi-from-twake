import 'package:fluffychat/data/model/search/omni_user_search_request.dart';
import 'package:fluffychat/data/model/search/omni_user_search_response.dart';

abstract class OmniUserSearchRepository {
  Future<OmniUserSearchResponse> userSearch(
    OmniUserSearchRequest request,
  );
}
