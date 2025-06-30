import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request.g.dart';

@JsonSerializable()
class SignupRequest with EquatableMixin {
  final String email;
  @JsonKey(name: 'password')
  final String password;

  SignupRequest({
    required this.email,
    required this.password,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
