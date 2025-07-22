import 'package:fluffychat/data/model/contact/omni_contact_request.dart';
import 'package:fluffychat/domain/model/contact/contact.dart';

abstract class OmniContactRepository {
  Future<List<Contact>> fetchContacts({
    OmniContactStatus? status,
  });
}
