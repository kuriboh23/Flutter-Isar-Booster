import 'dart:io';
import 'package:flutter_project_booster/install_dependencies.dart';
import 'package:flutter_project_booster/patch_isar.dart';
import 'package:flutter_project_booster/setup_gradle.dart';
import 'package:flutter_project_booster/utils.dart';

void main(List<String> args) async {
  clearScreen();
  printTitle('🚀 Flutter Project Booster\n');

  final dir = Directory.current.path;
  if (!isFlutterProject(dir)) {
    printError('❌ Not a valid Flutter project folder.');
    printWarn('🛑 Required: pubspec.yaml, lib/, android/, and sdk: flutter');
    exit(1);
  }

  final confirmed = confirmConsole('Are you SURE you want to setup this Flutter project? [y/N]');
  if (!confirmed) return;

  await patchGradleWrapper();
  await patchIsarFlutterLibs();
  await installDependencies();

  printGood('\n✅ Flutter project setup complete!');
}