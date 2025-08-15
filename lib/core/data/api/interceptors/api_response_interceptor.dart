import 'dart:convert';

import 'package:http/http.dart';

import 'package:identidaddigital/core/data/api/response/api_response.dart';
import 'package:identidaddigital/core/error/error.dart';

abstract class BaseApiResponseInterceptor {
  ApiResponse<T> call<T>(Response response);
}

class ApiResponseInterceptor extends BaseApiResponseInterceptor {
  @override
  ApiResponse<T> call<T>(Response response) {
    try {
      if (response.statusCode == 500) {
        throw InternalServerException();
      }

      if (response.statusCode == 200) {
        // Manejar respuesta vacía o nula del servidor
        if (response.body.isEmpty || response.body == 'null') {
          // Crear una respuesta exitosa con datos nulos
          return ApiResponse<T>(
            status: ResponseStatus(code: 1, message: 'Success'),
            data: null as T,
          );
        }

        final dynamic content = json.decode(response.body);

        // Manejar caso donde el contenido es null o no es un Map
        if (content == null) {
          return ApiResponse<T>(
            status: ResponseStatus(code: 1, message: 'Success'),
            data: null as T,
          );
        }

        // Si el contenido no es un Map, crear una respuesta exitosa
        if (content is! Map) {
          return ApiResponse<T>(
            status: ResponseStatus(code: 1, message: 'Success'),
            data: content as T,
          );
        }

        final apiResponse = ApiResponse<T>.fromMap(content);
        if (apiResponse.status.code == 400) {
          throw SessionExpiredException();
        }
        return apiResponse;
      } else if (response.statusCode == 400) {
        throw SessionExpiredException();
      } else {
        throw ServerException(
          'Ha ocurrido un error al comunicarse con el servidor (ERROR ${response.statusCode} ${response.reasonPhrase}).',
        );
      }
    } on FormatException {
      throw ServerException(
          'Ha ocurrido un error al comunicarse con el servidor. Por favor intenta de nuevo.');
    }
  }
}
