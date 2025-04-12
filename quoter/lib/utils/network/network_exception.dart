import 'base_error_response.dart';

class NetworkException implements Exception {
  String? message;
  int statusCode;
  ResponseStatus? response;

  NetworkException({
    required this.message,
    required this.statusCode,
    this.response,
  });
}
