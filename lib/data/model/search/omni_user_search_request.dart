import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'omni_user_search_request.g.dart';

@JsonSerializable()
class OmniUserSearchRequest with EquatableMixin {
  @JsonKey(name: 'search_term')
  final String searchTerm;
  @JsonKey(nullable: true)
  final int? limit;

  OmniUserSearchRequest({
    required this.searchTerm,
    this.limit,
  });

  factory OmniUserSearchRequest.fromJson(Map<String, dynamic> json) =>
      _$OmniUserSearchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OmniUserSearchRequestToJson(this);

  @override
  List<Object?> get props => [searchTerm, limit];
}
