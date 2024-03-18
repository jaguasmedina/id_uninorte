import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:identidaddigital/app.dart';
import 'package:identidaddigital/core/config/app_config.dart';
import 'package:identidaddigital/di/injection.dart';

Future<void> mainCommon(Flavor env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppConfig.forEnvironment(env);
  await configureInjection(env.value);
  runApp(App());
}
