import 'package:fluffychat/data/datasource/user_relation/hive_user_relation_datasource.dart';
import 'package:fluffychat/data/hive/dto/user_relation/user_relation_hive_obj.dart';
import 'package:fluffychat/data/hive/extension/user_relation_hive_obj_extension.dart';
import 'package:fluffychat/data/hive/hive_collection_multi_database.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/model/user_relation/user_relation.dart';
import 'package:fluffychat/domain/model/extensions/user_relation/user_relation_extension.dart';
import 'package:matrix/matrix.dart';

class HiveUserRelationDatasourceImpl extends HiveUserRelationDatasource {
  @override
  Future<List<UserRelation>> getUserRelationByUserId(String userId) async {
    final updateUserRelation = <UserRelation>[];
    final hiveCollectionMultiDatabase =
        await getIt.getAsync<HiveCollectionMultiDatabase>();
    final keys =
        (await hiveCollectionMultiDatabase.userRelationBox.getAllKeys())
            .where((key) => TupleKey.fromString(key).parts.first == userId)
            .toList();
    final userRelations =
        await hiveCollectionMultiDatabase.userRelationBox.getAll(keys);
    userRelations.removeWhere((state) => state == null);
    for (final userRelation in userRelations) {
      updateUserRelation.add(
        UserRelationHiveObj.fromJson(copyMap(userRelation!)).toUserRelation(),
      );
    }

    return updateUserRelation;
  }

  @override
  Future<void> saveUserRelationForUser(
    String userId,
    List<UserRelation> userRelations,
  ) async {
    final hiveCollectionMultiDatabase =
        await getIt.getAsync<HiveCollectionMultiDatabase>();
    for (final userRelation in userRelations) {
      final key = TupleKey(userId, userRelation.id).toString();
      await hiveCollectionMultiDatabase.userRelationBox.put(
        key,
        userRelation.toHiveObj().toJson(),
      );
    }
    return;
  }

  @override
  Future<void> deleteUserRelationBox() async {
    final hiveCollectionMultiDatabase =
        await getIt.getAsync<HiveCollectionMultiDatabase>();
    return hiveCollectionMultiDatabase.userRelationBox.clear();
  }
}
