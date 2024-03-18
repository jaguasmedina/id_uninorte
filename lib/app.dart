import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:identidaddigital/core/i18n/supported_locales.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/providers/providers.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/navigation/app_navigator.dart';
import 'package:identidaddigital/core/theme/app_theme.dart';

class App extends StatelessWidget {
  Locale _localeResolutionCallback(
    Locale locale,
    Iterable<Locale> supportedLocales,
  ) {
    if (locale == null) {
      Intl.defaultLocale = supportedLocales.first.toString();
      return supportedLocales.first;
    } else {
      for (final supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          Intl.defaultLocale = supportedLocale.toString();
          return supportedLocale;
        }
      }
      Intl.defaultLocale = supportedLocales.first.toString();
      return supportedLocales.first;
    }
  }

  String _generateTitle(BuildContext context) => getString(context, 'app_name');

  Widget _builder(BuildContext context, Widget child) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: ScrollConfiguration(
        behavior: NeverOverScrollBehavior(),
        child: AppTheme(
          data: AppThemeData.light(),
          child: child,
        ),
      ),
    );
  }

  void _handleStatusBar() {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _handleStatusBar();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: _generateTitle,
        navigatorKey: AppNavigator.navigatorKey,
        home: AppNavigator.home(),
        onGenerateRoute: AppNavigator.generateRoute,
        theme: AppTheme.light,
        builder: _builder,
        supportedLocales: SupportedLocales.locales,
        localeResolutionCallback: _localeResolutionCallback,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
