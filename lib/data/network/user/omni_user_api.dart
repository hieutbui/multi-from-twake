import 'package:fluffychat/data/model/search/omni_user_search_request.dart';
import 'package:fluffychat/data/model/search/omni_user_search_response.dart';
import 'package:fluffychat/data/network/dio_client.dart';
import 'package:fluffychat/data/network/omni_endpoint.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/di/global/network_di.dart';

class OmniUserApi {
  final DioClient _dioClient = getIt.get<DioClient>(
    instanceName: NetworkDI.omniDioClientName,
  );

  OmniUserApi();

  Future<OmniUserSearchResponse> userSearch(
    OmniUserSearchRequest request,
  ) async {
    final response = await _dioClient.get(
      OmniEndpoint.userSearchServicePath.generateOmniEndpoint(),
      queryParameters: request.toJson(),
    );

    return OmniUserSearchResponse.fromJson({'users': response});
  }
}
