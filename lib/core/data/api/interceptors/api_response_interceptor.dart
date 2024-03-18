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
        final dynamic content = json.decode(response.body);
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
