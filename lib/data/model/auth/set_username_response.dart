import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'set_username_response.g.dart';

@JsonSerializable()
class SetUsernameResponse with EquatableMixin {
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'display_name')
  @JsonKey(name: 'display_name')
  final String displayName;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'matrix_user_id')
  final String matrixUserId;
  @JsonKey(name: 'matrix_access_token')
  final String matrixAccessToken;
  @JsonKey(name: 'account_status')
  final String accountStatus;

  SetUsernameResponse({
    required this.userId,
    required this.username,
    required this.displayName,
    required this.email,
    required this.matrixUserId,
    required this.matrixAccessToken,
    required this.accountStatus,
  });

  factory SetUsernameResponse.fromJson(Map<String, dynamic> json) =>
      _$SetUsernameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SetUsernameResponseToJson(this);

  @override
  List<Object?> get props => [
        userId,
        username,
        displayName,
        email,
        matrixUserId,
        matrixAccessToken,
        accountStatus,
      ];
}
