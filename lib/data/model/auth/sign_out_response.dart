import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_out_response.g.dart';

@JsonSerializable()
class SignoutResponse with EquatableMixin {
  final String message;

  SignoutResponse({
    required this.message,
  });

  factory SignoutResponse.fromJson(Map<String, dynamic> json) =>
      _$SignoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignoutResponseToJson(this);

  @override
  List<Object?> get props => [message];
}
