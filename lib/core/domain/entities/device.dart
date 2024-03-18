import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Device extends Equatable {
  final String id;
  final String brand;
  final String model;
  final String systemName;
  final String systemVersion;

  const Device({
    @required this.id,
    @required this.brand,
    @required this.model,
    this.systemName,
    this.systemVersion,
  });

  @override
  List<Object> get props => [id];
}
