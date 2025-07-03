import 'package:fluffychat/data/datasource/contact/hive_contact_request_datasource.dart';
import 'package:fluffychat/data/hive/dto/contact/contact_request_hive_obj.dart';
import 'package:fluffychat/data/hive/extension/contact_request_hive_obj_extension.dart';
import 'package:fluffychat/data/hive/hive_collection_multi_database.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/model/contact/contact_request.dart';
import 'package:fluffychat/domain/model/extensions/contact/contact_request_extension.dart';
import 'package:matrix/matrix.dart';

class HiveContactRequestDatasourceImpl extends HiveContactRequestDatasource {
  @override
  Future<List<ContactRequest>> getContactRequestByUserId(String userId) async {
    final updateContactRequest = <ContactRequest>[];
    final hiveCollectionMultiDatabase =
        await getIt.getAsync<HiveCollectionMultiDatabase>();
    final keys =
        (await hiveCollectionMultiDatabase.contactRequestBox.getAllKeys())
            .where((key) => TupleKey.fromString(key).parts.first == userId)
            .toList();
    final contactRequests =
        await hiveCollectionMultiDatabase.contactRequestBox.getAll(keys);
    contactRequests.removeWhere((state) => state == null);
    for (final contactRequest in contactRequests) {
      updateContactRequest.add(
        ContactRequestHiveObj.fromJson(copyMap(contactRequest!))
            .toContactRequest(),
      );
    }

    return updateContactRequest;
  }

  @override
  Future<void> saveContactRequestForUser(
    String userId,
    List<ContactRequest> contactRequests,
  ) async {
    final hiveCollectionMultiDatabase =
        await getIt.getAsync<HiveCollectionMultiDatabase>();
    for (final contactRequest in contactRequests) {
      final key = TupleKey(userId, contactRequest.id).toString();
      await hiveCollectionMultiDatabase.contactRequestBox.put(
        key,
        contactRequest.toHiveObj().toJson(),
      );
    }
    return;
  }

  @override
  Future<void> deleteContactRequestBox() async {
    final hiveCollectionMultiDatabase =
        await getIt.getAsync<HiveCollectionMultiDatabase>();
    return hiveCollectionMultiDatabase.contactRequestBox.clear();
  }
}
