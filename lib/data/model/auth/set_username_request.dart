import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'set_username_request.g.dart';

@JsonSerializable()
class SetUsernameRequest with EquatableMixin {
  final String email;
  final String password;
  final String username;

  SetUsernameRequest({
    required this.email,
    required this.password,
    required this.username,
  });

  factory SetUsernameRequest.fromJson(Map<String, dynamic> json) =>
      _$SetUsernameRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SetUsernameRequestToJson(this);

  @override
  List<Object?> get props => [email, password, username];
}
