import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/api/client/api_client.dart';
import 'package:identidaddigital/core/data/api/constants/api_routes.dart';
import 'package:identidaddigital/core/data/api/services/device_service/device_service.dart';
import 'package:identidaddigital/core/enums/flavor.dart';
import 'package:identidaddigital/core/error/exceptions.dart';

@LazySingleton(as: DeviceService)
@Environment(Env.prod)
class DeviceServiceImpl implements DeviceService {
  final ApiClient client;

  DeviceServiceImpl(this.client);

  @override
  Future<bool> unlinkDevice(String email) async {
    try {
      if (email.isEmpty) {
        throw ServerException(
            'El email del usuario es requerido para desvincular el dispositivo');
      }

      final response = await client.post<dynamic>(
        ApiRoutes.unlinkDevice,
        body: <String, String>{'email': email},
      );

      if (response.isSuccessful) {
        return true;
      } else if (response.status.code == -1) {
        throw DeviceAlreadyUnlinkedException();
      } else {
        final errorMessage =
            _getErrorMessage(response.status.code, response.status.message);
        throw ServerException(errorMessage);
      }
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(
          'Error al desvincular el dispositivo: ${e.toString()}');
    }
  }

  String _getErrorMessage(int code, String? message) {
    switch (code) {
      case 401:
        return 'Sesión expirada. Por favor, inicia sesión nuevamente.';
      case 403:
        return 'No tienes permisos para realizar esta acción.';
      case 404:
        return 'El servicio de desvincular dispositivo no está disponible.';
      case 500:
        return 'Error interno del servidor. Por favor, intenta más tarde.';
      default:
        return message?.isNotEmpty == true
            ? message!
            : 'Error al desvincular el dispositivo. Código: $code';
    }
  }
}
