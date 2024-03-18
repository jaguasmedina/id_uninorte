import 'package:flutter/material.dart';

import 'package:identidaddigital/core/navigation/destinations.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/features/app_update/presentation/pages/update_required_page.dart';
import 'package:identidaddigital/features/auth/presentation/pages/login_page.dart';
import 'package:identidaddigital/features/digital_card/presentation/pages/digital_card_page.dart';
import 'package:identidaddigital/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:identidaddigital/features/profile_picture/presentation/pages/profile_picture_page.dart';
import 'package:identidaddigital/features/settings/presentation/pages/settings_page.dart';
import 'package:identidaddigital/features/splash/presentation/pages/splash_page.dart';

export 'package:identidaddigital/core/navigation/destinations.dart';

/// App navigation router.
class AppNavigator {
  static final _navigatorKey = GlobalKey<NavigatorState>();

  /// App root Navigator key.
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// Global App Navigator.
  static NavigatorState get navigator => navigatorKey.currentState;

  /// Generate the corresponding route when app is navigated
  /// to a named route.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Destinations.carnet:
        return MaterialPageRoute<dynamic>(builder: (_) => DigitalCardPage());

      case Destinations.onboarding:
        return OnboardingPage.route();

      case Destinations.updateRequired:
        return UpdateRequiredPage.route();

      case Destinations.login:
        if (args is LoginReason) {
          return FadeRoute<dynamic>(LoginPage(reason: args));
        }
        return FadeRoute<dynamic>(const LoginPage());

      case Destinations.profilePicture:
        return MaterialPageRoute<dynamic>(builder: (_) => ProfilePicturePage());

      case Destinations.settings:
        return MaterialPageRoute<dynamic>(builder: (_) => SettingsPage());

      default:
        return _errorRoute(
          settings.name,
          'No route defined for ${settings.name}',
        );
    }
  }

  /// Returns App home's [Widget].
  static Widget home() {
    return SplashPage();
  }

  // static String _invalidArgmuents(Type received, Type expected) {
  //   return 'Invalid argument of type $received, expected $expected';
  // }

  static Route<dynamic> _errorRoute(String routeName, String message) {
    return MaterialPageRoute<dynamic>(
      builder: (context) => RoutingErrorWidget(
        title: 'Routing error :p',
        subtitle: 'Trying to navigate to $routeName',
        message: message,
      ),
    );
  }
}
