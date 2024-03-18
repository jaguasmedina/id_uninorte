abstract class DestinationRepository {
  /// Returns the initial destination of the App.
  String requestInitialDestination();

  /// Returns the destination to which the onboarding page
  /// should be directed.
  String requestOnboardingDestination();

  /// Save that onboarding was shown.
  void saveOnboardingDidShow();
}
