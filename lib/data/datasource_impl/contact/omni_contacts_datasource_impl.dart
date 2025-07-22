import 'package:fluffychat/data/datasource/omni_contacts_datasource.dart';
import 'package:fluffychat/data/model/contact/omni_contact_request.dart';
import 'package:fluffychat/data/network/contact/omni_contact_api.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/model/contact/contact.dart';
import 'package:fluffychat/domain/model/extensions/contact/omni_contact_extension.dart';

class OmniContactsDatasourceImpl implements OmniContactsDatasource {
  final OmniContactApi _omniContactApi = getIt.get<OmniContactApi>();

  @override
  Future<List<Contact>> fetchContacts({
    OmniContactStatus? status,
  }) async {
    final response = await _omniContactApi.fetchContacts(
      OmniContactRequest(
        status: status ?? OmniContactStatus.accepted,
      ),
    );

    return response.contacts.map((contact) => contact.toContact()).toList();
  }
}
