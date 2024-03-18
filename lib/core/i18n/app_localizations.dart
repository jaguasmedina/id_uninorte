import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:identidaddigital/core/i18n/supported_locales.dart';

class AppLocalizations {
  final Locale locale;
  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
  AppLocalizations(this.locale);

  Map<String, String> _localizedStrings;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    final String jsonString = await rootBundle.loadString(
      'lang/${locale.languageCode}.json',
    );
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((String key, dynamic value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  /// Returns the localized text.
  String translate(String key) {
    final localizedText = _localizedStrings[key];
    assert(
      localizedText != null,
      'Trying to access a string resource that does not exist: $key',
    );
    return localizedText;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return SupportedLocales.langCodes.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

/// Returns the localized text
String getString(BuildContext context, String key) {
  return AppLocalizations.of(context).translate(key);
}
