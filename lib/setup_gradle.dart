import 'dart:io';
import 'utils.dart';

Future<void> patchGradleWrapper() async {
  final wrapperFile = File('android/gradle/wrapper/gradle-wrapper.properties');

  if (!wrapperFile.existsSync()) {
    printError('🔴 gradle-wrapper.properties not found.');
    return;
  }

  const localGradle = 'file:///C:/Gradle/gradle-8.11.1-all.zip';
  final lines = wrapperFile.readAsLinesSync();

  if (lines.any((line) => line.contains(localGradle))) {
    printWarn('⚠️ Gradle already patched.');
    return;
  }

  printInfo('🔧 Patching gradle-wrapper with local Gradle zip…');
  final modified = lines.map((line) {
    return line.startsWith('distributionUrl=') ? 'distributionUrl=$localGradle' : line;
  }).join('\n');

  wrapperFile.writeAsStringSync(modified);
  printGood('✅ Gradle patched.');
}