import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'omni_user_search_model.g.dart';

@JsonSerializable()
class OmniUserSearchModel with EquatableMixin {
  @JsonKey(name: 'user_id')
  final int userId;

  final String username;

  @JsonKey(name: 'display_name')
  final String displayName;

  @JsonKey(name: 'matrix_user_id')
  final String matrixUserId;

  @JsonKey(name: 'is_verified')
  final bool isVerified;

  @JsonKey(name: 'contact_status')
  final String? contactStatus;

  @JsonKey(name: 'contact_direction')
  final String? contactDirection;

  const OmniUserSearchModel({
    required this.userId,
    required this.username,
    required this.displayName,
    required this.matrixUserId,
    required this.isVerified,
    this.contactStatus,
    this.contactDirection,
  });

  factory OmniUserSearchModel.fromJson(Map<String, dynamic> json) =>
      _$OmniUserSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$OmniUserSearchModelToJson(this);

  @override
  List<Object?> get props => [
        userId,
        username,
        displayName,
        matrixUserId,
        isVerified,
        contactStatus,
        contactDirection,
      ];
}
