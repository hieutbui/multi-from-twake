import 'package:equatable/equatable.dart';

enum ContactRequestStatus {
  pending,
  accepted,
  reported,
  blocked;

  @override
  String toString() {
    switch (this) {
      case ContactRequestStatus.pending:
        return 'pending';
      case ContactRequestStatus.accepted:
        return 'accepted';
      case ContactRequestStatus.reported:
        return 'reported';
      case ContactRequestStatus.blocked:
        return 'blocked';
    }
  }
}

class ContactRequest extends Equatable {
  final String id;
  final ContactRequestStatus status;
  final String peerId;
  final String roomId;
  final ContactRequestLastEvent lastEvent;
  final int unreadCount;

  const ContactRequest({
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

  ContactRequest copyWith({
    String? id,
    ContactRequestStatus? status,
    String? peerId,
    String? roomId,
    ContactRequestLastEvent? lastEvent,
    int? unreadCount,
  }) {
    return ContactRequest(
      id: id ?? this.id,
      status: status ?? this.status,
      peerId: peerId ?? this.peerId,
      roomId: roomId ?? this.roomId,
      lastEvent: lastEvent ?? this.lastEvent,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}

class ContactRequestLastEvent extends Equatable {
  final String id;
  final DateTime originServerTs;
  final String type;

  const ContactRequestLastEvent({
    required this.id,
    required this.originServerTs,
    required this.type,
  });

  @override
  List<Object?> get props => [id, originServerTs, type];

  ContactRequestLastEvent copyWith({
    DateTime? originServerTs,
    String? type,
  }) {
    return ContactRequestLastEvent(
      id: id,
      originServerTs: originServerTs ?? this.originServerTs,
      type: type ?? this.type,
    );
  }
}
