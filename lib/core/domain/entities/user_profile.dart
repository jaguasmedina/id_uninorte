import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    @required this.name,
    @required this.title,
    @required this.colorHexStr,
  });

  final String name;
  final String title;
  final String colorHexStr;

  @override
  List<Object> get props => [name, title, colorHexStr];
}
