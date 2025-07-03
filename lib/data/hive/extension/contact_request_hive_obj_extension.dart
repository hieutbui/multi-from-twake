import 'package:fluffychat/data/hive/dto/contact/contact_request_hive_obj.dart';
import 'package:fluffychat/data/hive/dto/contact/contact_request_last_event_hive_obj.dart';
import 'package:fluffychat/domain/model/contact/contact_request.dart';

extension ContactRequestHiveObjExtension on ContactRequestHiveObj {
  ContactRequest toContactRequest() {
    return ContactRequest(
      id: id,
      status: status,
      peerId: peerId,
      roomId: roomId,
      lastEvent: lastEvent.toContactRequestLastEvent(),
      unreadCount: unreadCount,
    );
  }
}

extension ContactRequestLastEventHiveObjExtension
    on ContactRequestLastEventHiveObj {
  ContactRequestLastEvent toContactRequestLastEvent() {
    return ContactRequestLastEvent(
      id: id,
      originServerTs: originServerTs,
      type: type,
    );
  }
}
