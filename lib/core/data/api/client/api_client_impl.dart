import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/config/app_config.dart';
import 'package:identidaddigital/core/data/api/client/api_client.dart';
import 'package:identidaddigital/core/data/api/interceptors/api_response_interceptor.dart';
import 'package:identidaddigital/core/data/api/response/api_response.dart';
import 'package:identidaddigital/core/data/data_sources/preferences_data_source.dart';

@LazySingleton(as: ApiClient)
class ApiClientImpl extends ApiClient {
  ApiClientImpl(this._preferences) : super(ApiResponseInterceptor());

  /// Http client.
  final _client = http.Client();

  final PreferencesDataSource _preferences;

  /// Base API url.
  String get baseUrl => AppConfig.instance.apiUrl;

  /// Request's default headers.
  Map<String, String> get defaultHeaders {
    final token = _preferences.authToken;
    final authorization = token != null ? 'Bearer $token' : '';
    return {
      'Authorization': authorization,
      'tokenApp': AppConfig.instance.apiKey,
    };
  }

  /// POST Request's default headers.
  Map<String, String> get postDefaultHeaders {
    final token = _preferences.authToken;
    final authorization = token != null ? 'Bearer $token' : '';
    return {
      'Authorization': authorization,
      'Content-Type': 'application/json',
      'tokenApp': AppConfig.instance.apiKey,
    };
  }

  @override
  Future<ApiResponse<T>> getUrl<T>(
    String path, {
    Map<String, String> queryParameters,
    Map<String, String> headers,
  }) async {
    final requestHeaders = applyHeaders(headers, defaultHeaders);
    final uri = Uri.parse(baseUrl).replace(
      path: path,
      queryParameters: queryParameters,
    );
    final response = await _client.get(
      uri,
      headers: requestHeaders,
    );
    return onResponse(response);
  }

  @override
  String joinBaseUrl(String path) {
    return '$baseUrl$path';
  }

  @override
  Future<ApiResponse<T>> post<T>(
    String path, {
    Map<String, String> queryParameters,
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) async {
    final requestHeaders = applyHeaders(headers, postDefaultHeaders);
    final uri = Uri.parse(baseUrl).replace(
      path: path,
      queryParameters: queryParameters,
    );
    final response = await _client.post(
      uri,
      headers: requestHeaders,
      body: json.encode(body),
    );
    return onResponse(response);
  }

  @override
  Future<ApiResponse<T>> send<T>(http.BaseRequest request) async {
    request.headers?.addAll(defaultHeaders);
    final streamResponse = await _client.send(request);
    final response = await http.Response.fromStream(streamResponse);
    return onResponse(response);
  }

  /// Adds [appliedHeaders] to the given [headers].
  ///
  /// Overrides the key-value if already exist.
  Map<String, String> applyHeaders(
    Map<String, String> headers,
    Map<String, String> appliedHeaders,
  ) {
    if (headers != null) {
      final h = Map<String, String>.from(headers);
      h.addAll(appliedHeaders);
      return h;
    } else {
      return appliedHeaders;
    }
  }
}
