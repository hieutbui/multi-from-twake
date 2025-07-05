import 'package:fluffychat/data/datasource/user_relation/hive_user_relation_datasource.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/model/user_relation/user_relation.dart';
import 'package:fluffychat/domain/repository/user_relation/hive_user_relation_repository.dart';

class HiveUserRelationRepositoryImpl implements HiveUserRelationRepository {
  final HiveUserRelationDatasource datasource =
      getIt.get<HiveUserRelationDatasource>();

  @override
  Future<List<UserRelation>> getUserRelationByUserId(String userId) {
    return datasource.getUserRelationByUserId(userId);
  }

  @override
  Future<void> saveUserRelationForUser(
    String userId,
    List<UserRelation> userRelations,
  ) {
    return datasource.saveUserRelationForUser(userId, userRelations);
  }

  @override
  Future<void> deleteUserRelationBox() {
    return datasource.deleteUserRelationBox();
  }
}
