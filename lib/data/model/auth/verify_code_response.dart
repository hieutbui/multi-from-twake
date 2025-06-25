import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_code_response.g.dart';

@JsonSerializable()
class VerifyCodeResponse with EquatableMixin {
  final bool success;
  final String message;
  @JsonKey(name: 'user_id')
  final int userId;
  final String email;

  VerifyCodeResponse({
    required this.success,
    required this.message,
    required this.userId,
    required this.email,
  });

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyCodeResponseToJson(this);

  @override
  List<Object?> get props => [
        success,
        message,
        userId,
        email,
      ];
}
