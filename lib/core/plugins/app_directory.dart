import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract final class AppDirectory {
  static Directory? _appDocsDirectory;
  static Directory? _appCacheDirectory;

  static Future<void> init() async {
    _appCacheDirectory = await getTemporaryDirectory();
    _appDocsDirectory = await getApplicationDocumentsDirectory();
  }

  static Directory get appDocsDirectory => _appDocsDirectory!;
  static Directory get appCacheDirectory => _appCacheDirectory!;
}
