import 'package:dartz/dartz.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/direct_chat/create_direct_chat_failed.dart';
import 'package:fluffychat/domain/app_state/direct_chat/create_direct_chat_loading.dart';
import 'package:fluffychat/domain/app_state/direct_chat/create_direct_chat_success.dart';
import 'package:fluffychat/domain/model/user_relation/user_relation.dart';
import 'package:fluffychat/domain/repository/user_relation/hive_user_relation_repository.dart';
import 'package:matrix/matrix.dart';

class CreateDirectChatInteractor {
  Stream<Either<Failure, Success>> execute({
    required String contactMxId,
    required Client client,
    List<StateEvent>? initialState,
    bool enableEncryption = true,
    bool waitForSync = true,
    Map<String, dynamic>? powerLevelContentOverride,
    CreateRoomPreset? preset = CreateRoomPreset.trustedPrivateChat,
  }) async* {
    yield const Right(CreateDirectChatLoading());
    try {
      final roomId = await client.startDirectChat(
        contactMxId,
        initialState: initialState,
        enableEncryption: enableEncryption,
        waitForSync: waitForSync,
        powerLevelContentOverride: powerLevelContentOverride,
        preset: preset,
      );

      await _storeUserRelationToHiveForSender(
        client,
        roomId,
        contactMxId,
      );

      yield Right(CreateDirectChatSuccess(roomId: roomId));
    } catch (e) {
      yield Left(CreateDirectChatFailed(exception: e));
    }
  }

  Future<void> _storeUserRelationToHiveForSender(
    Client client,
    String roomId,
    String receiverId,
  ) async {
    final creatorId = client.userID!;

    if (creatorId.isEmpty) return;

    final userRelation = UserRelation(
      id: '${creatorId}_${roomId}_$receiverId',
      status: UserRelationStatus.pending,
      creatorId: creatorId,
      peerId: receiverId,
      roomId: roomId,
      lastEvent: UserRelationLastEvent(
        id: '',
        originServerTs: DateTime.now(),
        type: EventTypes.Unknown,
      ),
      unreadCount: 0,
    );

    try {
      final userRelationRepository = getIt.get<HiveUserRelationRepository>();

      final currentUserRelations =
          await userRelationRepository.getUserRelationByUserId(
        creatorId,
      );

      final existingRelationIndex = currentUserRelations.indexWhere(
        (ur) => ur.peerId == receiverId && ur.roomId == roomId,
      );

      if (existingRelationIndex >= 0) {
        if (currentUserRelations[existingRelationIndex].status !=
            UserRelationStatus.pending) {
          currentUserRelations[existingRelationIndex] = userRelation;
        }
      } else {
        currentUserRelations.add(userRelation);
      }

      await userRelationRepository.saveUserRelationForUser(
        creatorId,
        currentUserRelations,
      );
    } catch (e) {
      Logs().e('Failed to store user relation to Hive: $e');
    }
  }
}
