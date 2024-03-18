import 'package:flutter/material.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/domain/repositories/user_repository.dart';
import 'package:identidaddigital/di/injection.dart';

class UserProvider extends ChangeNotifier {
  User _user;
  final _userRepository = sl<UserRepository>();

  UserProvider() {
    _user = _userRepository.getUser();
  }

  User get user => _user;
  set user(User user) {
    _user = user;
    notifyListeners();
  }
}
