import 'dart:io';
import 'utils.dart';

Future<void> installDependencies() async {
  final pubspec = File('pubspec.yaml');
  if (pubspec.existsSync()) {
    printWarn('⚠️ pubspec.yaml already exists. Overwriting...');
  }

  final content = '''
name: boosted_project
description: A Flutter project boosted with CLI tools 💥

environment:
  sdk: ">=3.0.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  isar: ^3.1.0+1
  path_provider: ^2.1.5
  provider: ^6.1.5+1
  isar_flutter_libs: ^3.1.0+1
  colorize: ^3.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  isar_generator: ^3.1.0+1
  build_runner: ^2.4.6

flutter:
  uses-material-design: true
''';

  pubspec.writeAsStringSync(content);
  printInfo('📄 pubspec.yaml written.');

  printInfo('📦 Running flutter pub get...');
  await runCmd('flutter', ['pub', 'get']);

  printInfo('🛠 Running build_runner...');
  await runCmd('flutter', ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs']);
}