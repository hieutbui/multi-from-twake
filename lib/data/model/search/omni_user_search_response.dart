import 'package:equatable/equatable.dart';
import 'package:fluffychat/domain/model/search/omni_user_search_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'omni_user_search_response.g.dart';

@JsonSerializable()
class OmniUserSearchResponse with EquatableMixin {
  final List<OmniUserSearchModel> users;

  OmniUserSearchResponse({
    required this.users,
  });

  factory OmniUserSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$OmniUserSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OmniUserSearchResponseToJson(this);

  @override
  List<Object?> get props => [users];
}
