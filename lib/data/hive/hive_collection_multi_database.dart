import 'dart:convert';
import 'dart:io';

import 'package:fluffychat/utils/matrix_sdk_extensions/flutter_hive_collections_database.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';

class HiveCollectionMultiDatabase {
  final String name;
  final String? path;
  final HiveCipher? key;

  late BoxCollection _collection;

  String get _userRelationBoxName => 'user_relation_box';

  late CollectionBox<Map> userRelationBox;

  HiveCollectionMultiDatabase(this.name, this.path, {this.key});

  static Future<HiveCollectionMultiDatabase> databaseBuilder() async {
    Logs().d('Open Hive for Multi...');
    HiveAesCipher? hiverCipher;

    try {
      if (kIsWeb || PlatformInfos.isIOS) {
        throw MissingPluginException();
      }

      const secureStorage = FlutterSecureStorage();

      final containsEncryptionKey = await secureStorage.read(
            key: FlutterHiveCollectionsDatabase.cipherStorageKey,
          ) !=
          null;

      if (!containsEncryptionKey) {
        if (Platform.isLinux) throw MissingPluginException();

        final key = Hive.generateSecureKey();

        await secureStorage.write(
          key: FlutterHiveCollectionsDatabase.cipherStorageKey,
          value: base64UrlEncode(key),
        );
      }

      final rawEncryptionKey = await secureStorage.read(
        key: FlutterHiveCollectionsDatabase.cipherStorageKey,
      );

      if (rawEncryptionKey == null) throw MissingPluginException();

      hiverCipher = HiveAesCipher(base64Url.decode(rawEncryptionKey));
    } on MissingPluginException catch (_) {
      const FlutterSecureStorage()
          .delete(key: FlutterHiveCollectionsDatabase.cipherStorageKey)
          .catchError((_) {});

      Logs().i('Hive encryption is not supported on this platform');
    } catch (e, s) {
      const FlutterSecureStorage()
          .delete(key: FlutterHiveCollectionsDatabase.cipherStorageKey)
          .catchError((_) {});
      Logs().w('Unable to init Hive encryption', e, s);
    }

    final db = HiveCollectionMultiDatabase(
      'hive_collections_multi',
      await _findDatabasePath(),
      key: hiverCipher,
    );

    try {
      await db.open();
    } catch (e, s) {
      Logs().w('Unable to open Multi Hive.', e, s);

      const FlutterSecureStorage()
          .delete(key: FlutterHiveCollectionsDatabase.cipherStorageKey);
      await db.clear().catchError((_) {});
      await Hive.deleteFromDisk();
      rethrow;
    }

    Logs().d('Hive for Multi is ready');
    return db;
  }

  static Future<String> _findDatabasePath({String? path = 'multi_db'}) async {
    if (!kIsWeb) {
      Directory directory;

      try {
        if (Platform.isLinux) {
          directory = await getApplicationSupportDirectory();
        } else {
          directory = await getApplicationDocumentsDirectory();
        }
      } catch (_) {
        try {
          directory = await getLibraryDirectory();
        } catch (_) {
          directory = Directory.current;
        }
      }

      directory = Directory(
        directory.uri.resolve(kDebugMode ? 'hive_debug' : 'hive').toFilePath(),
      );
      directory.create(recursive: true);
      path = directory.path;
    }

    return path!;
  }

  Future<void> open() async {
    _collection = await BoxCollection.open(
      name,
      {
        _userRelationBoxName,
      },
      path: path,
      key: key,
    );
    userRelationBox = await _collection.openBox(
      _userRelationBoxName,
      preload: true,
    );
  }

  Future<void> clear() async {
    await userRelationBox.clear();

    if (PlatformInfos.isMobile) {
      await _collection.deleteFromDisk();
    }
  }
}
