import 'dart:io';

void printTitle(String message) => print('\x1B[36m$message\x1B[0m');
void printInfo(String message) => print('\x1B[34m$message\x1B[0m');
void printWarn(String message) => print('\x1B[33m$message\x1B[0m');
void printGood(String message) => print('\x1B[32m$message\x1B[0m');
void printError(String message) => print('\x1B[31m$message\x1B[0m');

void clearScreen() {
  if (Platform.isWindows) {
    Process.runSync("cls", [], runInShell: true);
  } else {
    print('\x1B[2J\x1B[0;0H');
  }
}

bool isFlutterProject(String path) {
  final pubspec = File('$path/pubspec.yaml');
  final libDir = Directory('$path/lib');
  final androidDir = Directory('$path/android');

  if (!pubspec.existsSync() || !libDir.existsSync() || !androidDir.existsSync()) {
    return false;
  }

  final lines = pubspec.readAsLinesSync();
  final hasFlutter = lines.any((line) => line.contains('sdk: flutter'));
  return hasFlutter;
}

Future<void> runCmd(String cmd, List<String> args) async {
  try {
    final process = await Process.start(cmd, args, runInShell: true);
    await stdout.addStream(process.stdout);
    await stderr.addStream(process.stderr);
    final exit = await process.exitCode;

    if (exit != 0) {
      throw 'Command failed: $cmd ${args.join(" ")}';
    }
  } catch (e) {
    printError('❌ $cmd failed: $e');
  }
}

bool confirmConsole(String text) {
  stdout.write('\n$text ');
  final input = stdin.readLineSync()?.toLowerCase().trim();
  return input == 'y';
}