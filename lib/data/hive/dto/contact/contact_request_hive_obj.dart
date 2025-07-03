import 'package:equatable/equatable.dart';
import 'package:fluffychat/data/hive/dto/contact/contact_request_last_event_hive_obj.dart';
import 'package:fluffychat/domain/model/contact/contact_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_request_hive_obj.g.dart';

@JsonSerializable(explicitToJson: true)
class ContactRequestHiveObj with EquatableMixin {
  final String id;

  final ContactRequestStatus status;

  final String peerId;

  final String roomId;

  final ContactRequestLastEventHiveObj lastEvent;

  final int unreadCount;

  ContactRequestHiveObj({
    required this.id,
    required this.status,
    required this.peerId,
    required this.roomId,
    required this.lastEvent,
    required this.unreadCount,
  });

  factory ContactRequestHiveObj.fromJson(Map<String, dynamic> json) =>
      _$ContactRequestHiveObjFromJson(json);

  Map<String, dynamic> toJson() => _$ContactRequestHiveObjToJson(this);

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
