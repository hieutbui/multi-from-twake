import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'o_auth_request.g.dart';

@JsonSerializable()
class OAuthRequest with EquatableMixin {
  final String provider;
  @JsonKey(name: 'id_token')
  final String idToken;

  OAuthRequest({
    required this.provider,
    required this.idToken,
  });

  factory OAuthRequest.fromJson(Map<String, dynamic> json) =>
      _$OAuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthRequestToJson(this);

  @override
  List<Object?> get props => [provider, idToken];
}
