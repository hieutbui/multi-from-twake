import 'package:fluffychat/data/model/contact/omni_contact_request.dart';
import 'package:fluffychat/data/model/contact/omni_contact_response.dart';
import 'package:fluffychat/data/network/dio_client.dart';
import 'package:fluffychat/data/network/omni_endpoint.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/di/global/network_di.dart';

class OmniContactApi {
  final DioClient _client =
      getIt.get<DioClient>(instanceName: NetworkDI.omniDioClientName);

  OmniContactApi();

  Future<OmniContactResponse> fetchContacts(
    OmniContactRequest? request,
  ) async {
    final requestParam =
        request ?? OmniContactRequest(status: OmniContactStatus.accepted);

    final response = await _client
        .get(
          OmniEndpoint.getContactServicePath.generateOmniEndpoint(),
          queryParameters: requestParam.toJson(),
        )
        .onError((error, stackTrace) => throw Exception(error));

    return OmniContactResponse.fromJson(response);
  }
}
