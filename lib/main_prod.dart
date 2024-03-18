import 'package:identidaddigital/core/config/app_config.dart';
import 'package:identidaddigital/main_common.dart';

/// Production main entry point.
Future<void> main() async {
  await mainCommon(Flavor.prod);
}
