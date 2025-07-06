import 'package:fluffychat/data/hive/dto/user_relation/user_relation_hive_obj.dart';
import 'package:fluffychat/data/hive/dto/user_relation/user_relation_last_event_hive_obj.dart';
import 'package:fluffychat/domain/model/user_relation/user_relation.dart';

extension UserRelationExtension on UserRelation {
  UserRelationHiveObj toHiveObj() {
    return UserRelationHiveObj(
      id: id,
      status: status,
      creatorId: creatorId,
      peerId: peerId,
      roomId: roomId,
      lastEvent: lastEvent.toHiveObj(),
      unreadCount: unreadCount,
    );
  }
}

extension UserRelationLastEventExtension on UserRelationLastEvent {
  UserRelationLastEventHiveObj toHiveObj() {
    return UserRelationLastEventHiveObj(
      id: id,
      originServerTs: originServerTs,
      type: type,
    );
  }
}
