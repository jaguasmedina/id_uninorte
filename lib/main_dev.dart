import 'package:identidaddigital/core/config/app_config.dart';
import 'package:identidaddigital/main_common.dart';

/// Development main entry point.
Future<void> main() async {
  await mainCommon(Flavor.dev);
}
