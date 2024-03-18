import 'package:meta/meta.dart';

@immutable
class RemoteConfig {
  const RemoteConfig({
    @required this.refreshTimeMilli,
    this.minVersionCode,
  });

  final int refreshTimeMilli;
  final int minVersionCode;

  @override
  String toString() =>
      'RemoteConfig(refreshTimeMilli: $refreshTimeMilli, minVersionCode: $minVersionCode)';
}
