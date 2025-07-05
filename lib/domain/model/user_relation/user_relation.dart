import 'package:equatable/equatable.dart';

enum UserRelationStatus {
  pending,
  accepted,
  reported,
  blocked;

  @override
  String toString() {
    switch (this) {
      case UserRelationStatus.pending:
        return 'pending';
      case UserRelationStatus.accepted:
        return 'accepted';
      case UserRelationStatus.reported:
        return 'reported';
      case UserRelationStatus.blocked:
        return 'blocked';
    }
  }
}

class UserRelation extends Equatable {
  final String id;
  final UserRelationStatus status;
  final String peerId;
  final String roomId;
  final UserRelationLastEvent lastEvent;
  final int unreadCount;

  const UserRelation({
    required this.id,
    required this.status,
    required this.peerId,
    required this.roomId,
    required this.lastEvent,
    required this.unreadCount,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        peerId,
        roomId,
        lastEvent,
        unreadCount,
      ];

  UserRelation copyWith({
    String? id,
    UserRelationStatus? status,
    String? peerId,
    String? roomId,
    UserRelationLastEvent? lastEvent,
    int? unreadCount,
  }) {
    return UserRelation(
      id: id ?? this.id,
      status: status ?? this.status,
      peerId: peerId ?? this.peerId,
      roomId: roomId ?? this.roomId,
      lastEvent: lastEvent ?? this.lastEvent,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}

class UserRelationLastEvent extends Equatable {
  final String id;
  final DateTime originServerTs;
  final String type;

  const UserRelationLastEvent({
    required this.id,
    required this.originServerTs,
    required this.type,
  });

  @override
  List<Object?> get props => [id, originServerTs, type];

  UserRelationLastEvent copyWith({
    DateTime? originServerTs,
    String? type,
  }) {
    return UserRelationLastEvent(
      id: id,
      originServerTs: originServerTs ?? this.originServerTs,
      type: type ?? this.type,
    );
  }
}
