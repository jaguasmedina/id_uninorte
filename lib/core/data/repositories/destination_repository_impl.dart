import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/data_sources/preferences_data_source.dart';
import 'package:identidaddigital/core/domain/repositories/destination_repository.dart';
import 'package:identidaddigital/core/navigation/destinations.dart';

@LazySingleton(as: DestinationRepository)
class DestinationRepositoryImpl implements DestinationRepository {
  final PreferencesDataSource preferences;

  DestinationRepositoryImpl(this.preferences);

  @override
  String requestInitialDestination() {
    final user = preferences.user;
    final onboardingDidShow = preferences.onboardingDidShow;
    final lasUpdatedTime = preferences.permissionsLastUpdatedTime;
    final permissionsHasExpired =
        lasUpdatedTime != null && lasUpdatedTime.isExpired;
    if (!onboardingDidShow) {
      return Destinations.onboarding;
    } else if (user != null &&
        user.canCreateCarnet &&
        !permissionsHasExpired &&
        !user.mustChangePassword) {
      return Destinations.carnet;
    } else {
      preferences.clearUserData();
      return Destinations.login;
    }
  }

  @override
  String requestOnboardingDestination() {
    final user = preferences.user;
    final lasUpdatedTime = preferences.permissionsLastUpdatedTime;
    final permissionsHasExpired =
        lasUpdatedTime != null && lasUpdatedTime.isExpired;
    if (user != null &&
        user.canCreateCarnet &&
        !permissionsHasExpired &&
        !user.mustChangePassword) {
      return Destinations.carnet;
    } else {
      preferences.clearUserData();
      return Destinations.login;
    }
  }

  @override
  void saveOnboardingDidShow() {
    preferences.onboardingDidShow = true;
  }
}
