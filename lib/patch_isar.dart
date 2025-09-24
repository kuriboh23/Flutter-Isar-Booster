import 'dart:io';
import 'package:path/path.dart' as p;
import 'utils.dart';

Future<void> patchIsarFlutterLibs() async {
  final home = Platform.environment['USERPROFILE'] ?? Platform.environment['HOME'];
  final path = p.join(
    home!,
    'AppData', 'Local', 'Pub', 'Cache', 'hosted',
    'pub.dev', 'isar_flutter_libs-3.1.0+1', 'android', 'build.gradle',
  );

  final file = File(path);
  if (!file.existsSync()) {
    printError('❌ isar_flutter_libs Gradle file not found.');
    return;
  }

  final content = file.readAsStringSync();
  if (content.contains('namespace')) {
    printWarn('⚠️ Already patched.');
    return;
  }

  final updated = content.replaceFirst(
    'android {',
    'android {\n    namespace "dev.isar.isar_flutter_libs"',
  );

  file.writeAsStringSync(updated);
  printGood('✅ Patched isar_flutter_libs.');
}