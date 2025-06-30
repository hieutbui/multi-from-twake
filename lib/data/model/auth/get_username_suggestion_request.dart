import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_username_suggestion_request.g.dart';

@JsonSerializable()
class GetUsernameSuggestionRequest with EquatableMixin {
  @JsonKey(name: 'display_name')
  final String displayName;

  GetUsernameSuggestionRequest({
    required this.displayName,
  });

  factory GetUsernameSuggestionRequest.fromJson(Map<String, dynamic> json) =>
      _$GetUsernameSuggestionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetUsernameSuggestionRequestToJson(this);

  @override
  List<Object?> get props => [displayName];
}
