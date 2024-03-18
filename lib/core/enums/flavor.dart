/// Build product flavors.
enum Flavor {
  dev,
  prod,
}

extension FlavorExtensions on Flavor {
  /// Returns the corresponding [String] value for this [Flavor].
  String get value {
    switch (this) {
      case Flavor.dev:
        return Env.dev;
      case Flavor.prod:
        return Env.prod;
      default:
        return Env.dev;
    }
  }
}

abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
}
