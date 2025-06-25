import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse with EquatableMixin {
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'matrix_user_id')
  final String matrixUserId;
  @JsonKey(name: 'matrix_access_token')
  final String matrixAccessToken;

  AuthResponse({
    required this.userId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.matrixUserId,
    required this.matrixAccessToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  @override
  List<Object?> get props => [
        userId,
        username,
        firstName,
        lastName,
        email,
        matrixUserId,
        matrixAccessToken,
      ];
}
