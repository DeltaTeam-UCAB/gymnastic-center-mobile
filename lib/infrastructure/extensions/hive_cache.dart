import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path_helper;

/// Extension adapted for using Hive as a cache provider.
extension HiveCache on HiveInterface {
  /// Initializes Hive with the path from [getApplicationDocumentsDirectory].
  ///
  /// You can provide a [subDir] where the boxes should be stored.
  ///
  /// Modification for using cache directory instead of documents directory.
  Future<void> initForCache([String? subDir]) async {
    WidgetsFlutterBinding.ensureInitialized();

    var appDir = await getApplicationCacheDirectory();
    init(path_helper.join(appDir.path, subDir));
  }
}
