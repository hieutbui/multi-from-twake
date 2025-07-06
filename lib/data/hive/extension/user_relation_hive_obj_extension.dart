import 'package:fluffychat/data/hive/dto/user_relation/user_relation_hive_obj.dart';
import 'package:fluffychat/data/hive/dto/user_relation/user_relation_last_event_hive_obj.dart';
import 'package:fluffychat/domain/model/user_relation/user_relation.dart';

extension UserRelationHiveObjExtension on UserRelationHiveObj {
  UserRelation toUserRelation() {
    return UserRelation(
      id: id,
      status: status,
      creatorId: creatorId,
      peerId: peerId,
      roomId: roomId,
      lastEvent: lastEvent.toUserRelationLastEvent(),
      unreadCount: unreadCount,
    );
  }
}

extension UserRelationLastEventHiveObjExtension
    on UserRelationLastEventHiveObj {
  UserRelationLastEvent toUserRelationLastEvent() {
    return UserRelationLastEvent(
      id: id,
      originServerTs: originServerTs,
      type: type,
    );
  }
}
