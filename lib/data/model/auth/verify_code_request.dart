import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_code_request.g.dart';

@JsonSerializable()
class VerifyCodeRequest with EquatableMixin {
  final String email;
  @JsonKey(name: 'verification_code')
  final String verificationCode;

  VerifyCodeRequest({
    required this.email,
    required this.verificationCode,
  });

  factory VerifyCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyCodeRequestToJson(this);

  @override
  List<Object?> get props => [email, verificationCode];
}
