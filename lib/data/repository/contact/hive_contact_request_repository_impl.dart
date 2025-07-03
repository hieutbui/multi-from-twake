import 'package:fluffychat/data/datasource/contact/hive_contact_request_datasource.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/model/contact/contact_request.dart';
import 'package:fluffychat/domain/repository/contact/hive_contact_request_repository.dart';

class HiveContactRequestRepositoryImpl implements HiveContactRequestRepository {
  final HiveContactRequestDatasource datasource =
      getIt.get<HiveContactRequestDatasource>();

  @override
  Future<List<ContactRequest>> getContactRequestByUserId(String userId) {
    return datasource.getContactRequestByUserId(userId);
  }

  @override
  Future<void> saveContactRequestForUser(
    String userId,
    List<ContactRequest> contactRequests,
  ) {
    return datasource.saveContactRequestForUser(userId, contactRequests);
  }

  @override
  Future<void> deleteContactRequestBox() {
    return datasource.deleteContactRequestBox();
  }
}
