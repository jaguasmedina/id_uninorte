import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:identidaddigital/core/enums/flavor.dart';

export 'package:identidaddigital/core/enums/flavor.dart';

class AppConfig {
  /// Api base url.
  final String apiUrl;

  /// Api access key.
  final String apiKey;

  static AppConfig _instance;

  AppConfig({
    @required this.apiUrl,
    @required this.apiKey,
  });

  factory AppConfig.fromMap(Map map) {
    return AppConfig(
      apiUrl: map['api_url'],
      apiKey: map['api_access_key'],
    );
  }

  /// Instance of [AppConfig].
  static AppConfig get instance => _instance;

  /// Loads configuration for the given [Flavor].
  static Future<void> forEnvironment(Flavor config) async {
    final env = config.value;
    final contents = await rootBundle.loadString(
      'config/$env.json',
    );
    final dynamic json = jsonDecode(contents);
    _instance = AppConfig.fromMap(json);
  }
}
