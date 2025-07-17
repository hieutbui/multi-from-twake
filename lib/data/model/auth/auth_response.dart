import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse with EquatableMixin {
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'display_name', nullable: true)
  final String? displayName;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'matrix_user_id')
  final String matrixUserId;
  @JsonKey(name: 'matrix_access_token')
  final String matrixAccessToken;
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'token_type')
  final String tokenType;

  AuthResponse({
    required this.username,
    required this.email,
    required this.matrixUserId,
    required this.matrixAccessToken,
    required this.accessToken,
    required this.tokenType,
    this.displayName,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  @override
  List<Object?> get props => [
        username,
        displayName,
        email,
        matrixUserId,
        matrixAccessToken,
        accessToken,
        tokenType,
      ];
}
