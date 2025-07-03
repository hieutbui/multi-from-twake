import 'package:fluffychat/domain/model/contact/contact_request.dart';

abstract class HiveContactRequestDatasource {
  Future<List<ContactRequest>> getContactRequestByUserId(String userId);

  Future<void> saveContactRequestForUser(
    String userId,
    List<ContactRequest> contactRequests,
  );

  Future<void> deleteContactRequestBox();
}
