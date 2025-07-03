import 'package:fluffychat/data/hive/dto/contact/contact_request_hive_obj.dart';
import 'package:fluffychat/data/hive/dto/contact/contact_request_last_event_hive_obj.dart';
import 'package:fluffychat/domain/model/contact/contact_request.dart';

extension ContactRequestExtension on ContactRequest {
  ContactRequestHiveObj toHiveObj() {
    return ContactRequestHiveObj(
      id: id,
      status: status,
      peerId: peerId,
      roomId: roomId,
      lastEvent: lastEvent.toHiveObj(),
      unreadCount: unreadCount,
    );
  }
}

extension ContactRequestLastEventExtension on ContactRequestLastEvent {
  ContactRequestLastEventHiveObj toHiveObj() {
    return ContactRequestLastEventHiveObj(
      id: id,
      originServerTs: originServerTs,
      type: type,
    );
  }
}
