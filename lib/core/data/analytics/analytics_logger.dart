part of core.data.analytics;

abstract class AnalyticsLogger {
  Future<void> setUser(User user);

  Future<void> logEvent(AppEvent event);
}

@LazySingleton(as: AnalyticsLogger)
class AnalyticsLoggerImpl implements AnalyticsLogger {
  final _analytics = FirebaseAnalytics();

  @override
  Future<void> logEvent(AppEvent event) async {
    try {
      await _analytics.logEvent(
        name: event.name,
        parameters: event.buildParameters(),
      );
    } catch (_) {}
  }

  @override
  Future<void> setUser(User user) async {
    try {
      await _analytics.setUserId(user.id);
      await _analytics.setUserProperty(name: 'email', value: user.currentEmail);
      await _analytics.setUserProperty(name: 'name', value: user.name);
    } catch (_) {}
  }
}
