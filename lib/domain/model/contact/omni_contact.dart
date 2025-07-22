import 'package:equatable/equatable.dart';
import 'package:fluffychat/data/model/contact/omni_contact_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'omni_contact.g.dart';

@JsonSerializable()
class OmniContact with EquatableMixin {
  final int id;
  @JsonKey(name: "from_user_id")
  final int fromUserId;
  @JsonKey(name: "to_user_id")
  final int toUserId;
  final OmniContactStatus status;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "updated_at")
  final DateTime updatedAt;
  @JsonKey(name: "is_favorite")
  final bool isFavorite;
  @JsonKey(name: "is_blocked")
  final bool isBlocked;
  final String notes;
  @JsonKey(name: "relation_type")
  final String relationType;
  @JsonKey(name: "user_id")
  final int userId;
  @JsonKey(name: "matrix_user_id")
  final String matrixUserId;
  @JsonKey(name: "username")
  final String username;
  @JsonKey(name: "display_name")
  final String displayName;
  @JsonKey(name: "avatar_url", nullable: true)
  final String? avatarUrl;

  OmniContact({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.isFavorite,
    required this.isBlocked,
    required this.notes,
    required this.relationType,
    required this.userId,
    required this.matrixUserId,
    required this.username,
    required this.displayName,
    this.avatarUrl,
  });

  factory OmniContact.fromJson(Map<String, dynamic> json) =>
      _$OmniContactFromJson(json);

  Map<String, dynamic> toJson() => _$OmniContactToJson(this);

  @override
  List<Object?> get props => [
        id,
        fromUserId,
        toUserId,
        status,
        createdAt,
        updatedAt,
        isFavorite,
        isBlocked,
        notes,
        relationType,
        userId,
        matrixUserId,
        username,
        displayName,
        avatarUrl,
      ];
}
