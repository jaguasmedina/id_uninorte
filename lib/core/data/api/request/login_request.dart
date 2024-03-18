import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:identidaddigital/core/data/models/models.dart';

class LoginRequest extends Equatable {
  final AuthCredentialsModel credentials;
  final DeviceModel device;

  const LoginRequest({
    @required this.credentials,
    @required this.device,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ...credentials.toMap(),
      ...device.toMap(),
    };
  }

  @override
  List<Object> get props => [credentials, device];
}
