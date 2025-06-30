import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'set_display_name_response.g.dart';

@JsonSerializable()
class SetDisplayNameResponse with EquatableMixin {
  @JsonKey(name: 'user_id')
  final int userId;
  final String email;
  @JsonKey(name: 'display_name')
  final String displayName;
  @JsonKey(name: 'username', nullable: true)
  final String? username;
  @JsonKey(name: 'is_profile_complete')
  final bool isProfileComplete;

  SetDisplayNameResponse({
    required this.userId,
    required this.email,
    required this.displayName,
    required this.username,
    required this.isProfileComplete,
  });

  factory SetDisplayNameResponse.fromJson(Map<String, dynamic> json) =>
      _$SetDisplayNameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SetDisplayNameResponseToJson(this);

  @override
  List<Object?> get props => [
        userId,
        email,
        displayName,
        username,
        isProfileComplete,
      ];
}
