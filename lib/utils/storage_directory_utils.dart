import 'package:path_provider/path_provider.dart';

class StorageDirectoryUtils {
  StorageDirectoryUtils._();

  static final StorageDirectoryUtils _instance = StorageDirectoryUtils._();

  static StorageDirectoryUtils get instance => _instance;

  static String? _tempDirectoryPath;

  Future<String> getFileStoreDirectory() async {
    try {
      try {
        return (await getTemporaryDirectory()).path;
      } catch (_) {
        return (await getApplicationDocumentsDirectory()).path;
      }
    } catch (_) {
      return (await getDownloadsDirectory())!.path;
    }
  }

  Future<String> getDownloadFolderInApp() async {
    _tempDirectoryPath ??= (await getTemporaryDirectory()).path;
    return '$_tempDirectoryPath/Downloads';
  }
}
