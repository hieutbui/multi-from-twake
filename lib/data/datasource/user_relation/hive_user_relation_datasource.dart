import 'package:fluffychat/domain/model/user_relation/user_relation.dart';

abstract class HiveUserRelationDatasource {
  Future<List<UserRelation>> getUserRelationByUserId(String userId);

  Future<void> saveUserRelationForUser(
    String userId,
    List<UserRelation> userRelations,
  );

  Future<void> deleteUserRelationBox();
}
