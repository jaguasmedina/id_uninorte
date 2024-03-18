import 'package:http/http.dart' as http;
import 'package:identidaddigital/core/data/api/interceptors/api_response_interceptor.dart';
import 'package:identidaddigital/core/data/api/response/api_response.dart';

/// Digital Id client class to manage network requests.
abstract class ApiClient {
  ApiClient(this.onResponse);

  final BaseApiResponseInterceptor onResponse;

  /// Sends an HTTP GET request with the given headers to the given [path].
  ///
  /// Returns the decoded json from the response body.
  Future<ApiResponse<T>> getUrl<T>(
    String path, {
    Map<String, String> queryParameters,
    Map<String, String> headers,
  });

  /// Sends an HTTP POST request with the given headers to the given [path].
  ///
  /// Receive a Map as the request's body.
  ///
  /// The content-type of the request will be set to `"application/x-www-form-urlencoded"`.
  Future<ApiResponse<T>> post<T>(
    String path, {
    Map<String, String> queryParameters,
    Map<String, String> headers,
    Map<String, dynamic> body,
  });

  /// Use this method to make `multipart/form-data` request.
  ///
  /// ```
  /// var client = new Client();
  /// var uri = Uri.parse("http://pub.dartlang.org/packages/create");
  /// var request = new http.MultipartRequest("POST", uri);
  /// request.fields['user'] = 'nweiz@google.com';
  /// request.files.add(
  ///   new http.MultipartFile.fromString(
  ///     'package',
  ///     'build/package.tar.gz',
  ///     contentType: MediaType('application', 'x-tar'),
  ///   ),
  /// );
  /// client.send(request);
  /// ```
  Future<ApiResponse<T>> send<T>(http.BaseRequest request);

  /// Join the given [path] to the base Url.
  String joinBaseUrl(String path);
}
