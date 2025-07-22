import 'package:fluffychat/data/datasource/omni_contacts_datasource.dart';
import 'package:fluffychat/data/model/contact/omni_contact_request.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/model/contact/contact.dart';
import 'package:fluffychat/domain/repository/contact/omni_contact_repository.dart';

class OmniContactRepositoryImpl implements OmniContactRepository {
  final OmniContactsDatasource _datasource =
      getIt.get<OmniContactsDatasource>();

  @override
  Future<List<Contact>> fetchContacts({
    OmniContactStatus? status,
  }) async {
    return _datasource.fetchContacts(
      status: status,
    );
  }
}
