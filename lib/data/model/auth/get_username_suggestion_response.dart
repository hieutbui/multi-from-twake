import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_username_suggestion_response.g.dart';

@JsonSerializable()
class GetUsernameSuggestionResponse with EquatableMixin {
  final List<String> suggestions;

  GetUsernameSuggestionResponse({
    required this.suggestions,
  });

  factory GetUsernameSuggestionResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUsernameSuggestionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUsernameSuggestionResponseToJson(this);

  @override
  List<Object?> get props => [suggestions];
}
