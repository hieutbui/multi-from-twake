import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_relation_last_event_hive_obj.g.dart';

@JsonSerializable(explicitToJson: true)
class UserRelationLastEventHiveObj with EquatableMixin {
  final String id;
  final DateTime originServerTs;
  final String type;

  UserRelationLastEventHiveObj({
    required this.id,
    required this.originServerTs,
    required this.type,
  });

  factory UserRelationLastEventHiveObj.fromJson(Map<String, dynamic> json) =>
      _$UserRelationLastEventHiveObjFromJson(json);

  Map<String, dynamic> toJson() => _$UserRelationLastEventHiveObjToJson(this);

  @override
  List<Object?> get props => [
        id,
        originServerTs,
        type,
      ];
}
