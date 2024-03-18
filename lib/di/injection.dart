// **************************************************************************
// To build Injectable generated file run:
// flutter packages pub run build_runner build --delete-conflicting-outputs
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:image_picker/image_picker.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info/package_info.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:identidaddigital/di/injection.config.dart';

/// Service Locator.
final GetIt sl = GetIt.instance;

/// Register and inject dependencies.
@InjectableInit(preferRelativeImports: false)
Future<void> configureInjection(String env) => $initGetIt(sl, environment: env);

/// Abstract class to manage third party dependencies registration.
@module
abstract class AppModule {
  @preResolve
  @lazySingleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @preResolve
  @lazySingleton
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  DataConnectionChecker get dataConnectionChecker => DataConnectionChecker();

  @lazySingleton
  LocalAuthentication get localAuthentication => LocalAuthentication();

  @lazySingleton
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();

  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();

  @lazySingleton
  ScreenBrightness get screenBrightness => ScreenBrightness();
}
