import 'package:identidaddigital/core/domain/entities/entities.dart';

abstract class UserRepository {
  /// Get stored user.
  User getUser();

  /// Update current user.
  void updateUser(User user);

  /// Clear current user.
  void clearUser();
}