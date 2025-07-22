import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'omni_contact_request.g.dart';

enum OmniContactStatus {
  pending,
  accepted,
  rejected,
  all,
}

@JsonSerializable()
class OmniContactRequest with EquatableMixin {
  final OmniContactStatus status;

  OmniContactRequest({
    required this.status,
  });

  factory OmniContactRequest.fromJson(Map<String, dynamic> json) =>
      _$OmniContactRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OmniContactRequestToJson(this);

  @override
  List<Object?> get props => [status];
}
