import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_request.g.dart';

@JsonSerializable()
class SigninRequest with EquatableMixin {
  final String email;
  final String password;

  SigninRequest({
    required this.email,
    required this.password,
  });

  factory SigninRequest.fromJson(Map<String, dynamic> json) =>
      _$SigninRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SigninRequestToJson(this);

  @override
  List<Object?> get props => [email, password];
}
