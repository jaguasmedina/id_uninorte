import 'package:meta/meta.dart';

class ApiResponse<T> {
  final ResponseStatus status;
  final T data;

  ApiResponse({
    required this.status,
    required this.data,
  });

  factory ApiResponse.fromMap(Map map) {
    return ApiResponse(
      status: ResponseStatus.fromMap(map['status'] ?? {}),
      data: map['data'] ?? null,
    );
  }

  bool get isSuccessful => status.code == 1;

  bool get isUnsuccessful => status.code != 1;
}

class ResponseStatus {
  final int code;
  final String message;

  ResponseStatus({
    required this.code,
    required this.message,
  });

  factory ResponseStatus.fromMap(Map map) {
    return ResponseStatus(
      code: map['code'] ?? 1,
      message: map['message'] ?? 'Success',
    );
  }
}
