import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'set_display_name_request.g.dart';

@JsonSerializable()
class SetDisplayNameRequest with EquatableMixin {
  final String email;
  final String password;
  @JsonKey(name: 'display_name')
  final String displayName;

  SetDisplayNameRequest({
    required this.email,
    required this.password,
    required this.displayName,
  });

  factory SetDisplayNameRequest.fromJson(Map<String, dynamic> json) =>
      _$SetDisplayNameRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SetDisplayNameRequestToJson(this);

  @override
  List<Object?> get props => [email, password, displayName];
}
