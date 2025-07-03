import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_request_last_event_hive_obj.g.dart';

@JsonSerializable(explicitToJson: true)
class ContactRequestLastEventHiveObj with EquatableMixin {
  final String id;
  final DateTime originServerTs;
  final String type;

  ContactRequestLastEventHiveObj({
    required this.id,
    required this.originServerTs,
    required this.type,
  });

  factory ContactRequestLastEventHiveObj.fromJson(Map<String, dynamic> json) =>
      _$ContactRequestLastEventHiveObjFromJson(json);

  Map<String, dynamic> toJson() => _$ContactRequestLastEventHiveObjToJson(this);

  @override
  List<Object?> get props => [
        id,
        originServerTs,
        type,
      ];
}
