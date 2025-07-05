import 'package:equatable/equatable.dart';
import 'package:fluffychat/data/hive/dto/user_relation/user_relation_last_event_hive_obj.dart';
import 'package:fluffychat/domain/model/user_relation/user_relation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_relation_hive_obj.g.dart';

@JsonSerializable(explicitToJson: true)
class UserRelationHiveObj with EquatableMixin {
  final String id;

  final UserRelationStatus status;

  final String peerId;

  final String roomId;

  final UserRelationLastEventHiveObj lastEvent;

  final int unreadCount;

  UserRelationHiveObj({
    required this.id,
    required this.status,
    required this.peerId,
    required this.roomId,
    required this.lastEvent,
    required this.unreadCount,
  });

  factory UserRelationHiveObj.fromJson(Map<String, dynamic> json) =>
      _$UserRelationHiveObjFromJson(json);

  Map<String, dynamic> toJson() => _$UserRelationHiveObjToJson(this);

  @override
  List<Object?> get props => [
        id,
        status,
        peerId,
        roomId,
        lastEvent,
        unreadCount,
      ];
}
