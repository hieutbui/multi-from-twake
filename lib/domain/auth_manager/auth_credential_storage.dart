import 'package:fluffychat/data/hive/hive_collection_multi_database.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:matrix/matrix.dart';

class AuthCredentialStorage {
  static const String _omniTokenKey = 'omni_access_token';

  static String? _cachedOmniToken;

  AuthCredentialStorage();

  Future<void> saveOmniAccessToken(String? token) async {
    _saveTokenToDatabase(token);
  }

  Future<String?> getOmniAccessToken() async {
    if (_cachedOmniToken != null) {
      return _cachedOmniToken;
    }

    return _loadTokenFromDatabase();
  }

  Future<void> clearOmniAccessToken() async {
    await _clearTokenFromDatabase();
  }

  Future<void> _saveTokenToDatabase(String? token) async {
    try {
      final database = await getIt.getAsync<HiveCollectionMultiDatabase>();

      if (token == null) {
        await database.authCredentialBox.delete(_omniTokenKey);
      } else {
        await database.authCredentialBox.put(_omniTokenKey, {
          _omniTokenKey: token,
        });
      }
    } catch (e) {
      Logs().e('Error saving token to database: $e');
    }
  }

  Future<String?> _loadTokenFromDatabase() async {
    try {
      final database = await getIt.getAsync<HiveCollectionMultiDatabase>();
      final data = await database.authCredentialBox.get(_omniTokenKey);

      _cachedOmniToken = data?[_omniTokenKey];
      return _cachedOmniToken;
    } catch (e) {
      Logs().e('Error loading token from database: $e');
      return null;
    }
  }

  Future<void> _clearTokenFromDatabase() async {
    try {
      final database = await getIt.getAsync<HiveCollectionMultiDatabase>();
      await database.authCredentialBox.delete(_omniTokenKey);
    } catch (e) {
      Logs().e('Error clearing token from database: $e');
    }
  }
}
