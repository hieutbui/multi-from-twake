import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_response.g.dart';

@JsonSerializable()
class SignupResponse with EquatableMixin {
  @JsonKey(name: 'user_id')
  final int userId;
  final String email;
  final String status;
  @JsonKey(name: 'verification_code')
  final String verificationCode;

  SignupResponse({
    required this.userId,
    required this.email,
    required this.status,
    required this.verificationCode,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);

  @override
  List<Object?> get props => [
        userId,
        email,
        status,
        verificationCode,
      ];
}
