import 'package:equatable/equatable.dart';
import 'package:fluffychat/domain/model/contact/omni_contact.dart';
import 'package:json_annotation/json_annotation.dart';

part 'omni_contact_response.g.dart';

@JsonSerializable()
class OmniContactResponse with EquatableMixin {
  final List<OmniContact> contacts;
  final int count;

  OmniContactResponse({
    required this.contacts,
    required this.count,
  });

  factory OmniContactResponse.fromJson(Map<String, dynamic> json) =>
      _$OmniContactResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OmniContactResponseToJson(this);

  @override
  List<Object?> get props => [contacts, count];
}
