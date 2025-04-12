
import 'dart:convert';
import 'dart:io';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:quoter/utils/network/base_error_response.dart';
import 'package:quoter/utils/network/network_exception.dart';


class DioClient {

  static final DioClient _instance = DioClient._internal();

  factory DioClient() {
    return _instance;
  }

  DioClient._internal();

  static const Duration connectionTimeout = Duration(milliseconds: 30000);
  static const Duration receiveTimeout = Duration(milliseconds: 30000);


  Dio get _dio {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://cungdev.com/',
      connectTimeout: connectionTimeout,
      receiveTimeout: connectionTimeout,
    ))
      ..interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true))
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    //dio.interceptors.add(ChuckerDioInterceptor());
    return dio;
  }

  Future<Map<String, dynamic>> headers(Map<String, dynamic> options, bool authRequired) async {
    final Map<String, dynamic> headers = {};
    try {
      if (authRequired) {
      }
    } catch (e) {
      print(e);
    }
    return headers;
  }

  // Xử lý chung với hệ thống
  Future<NetworkException> _handleApiError(DioException e) async {
    final response = e.response;
    final int statusCode = response?.statusCode ?? -1;

    if (response == null) {
      if (e.error is SocketException) {
        return NetworkException(
          message: e.message,
          statusCode: statusCode,
        );
      }
      return NetworkException(
        message: e.message,
        statusCode: statusCode,
      );
    }
    // Nếu đã đăng nhập
    if (statusCode == 401 || statusCode == 405) {
      //TODO : Check neu da dang nhap thi navigate ve login
    }
    try{
      BaseErrorResponse error = BaseErrorResponse.fromJson(response.data);
      return NetworkException(
        message: error.responseStatus?.message ?? '',
        statusCode: statusCode,
        response: error.responseStatus,
      );
    } catch(e){
      return NetworkException(
          message: response.statusMessage ?? "Có lỗi xảy ra",
          statusCode: statusCode
      );
    }
  }

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
      String uri, {
        bool authRequired = false,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {

      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: await headers(options?.headers ?? {}, authRequired),
        ),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on DioException catch (e) {
      print('DioError ${e.message}');
      final exception = await _handleApiError(e);
      throw exception;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
      String uri, {
        bool authRequired = false,
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        String? contentType
      }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          contentType: contentType ?? Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: await headers(options?.headers ?? {}, authRequired),
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioError catch (e) {
      final exception = await _handleApiError(e);
      throw exception;
    }
  }

  // Delete:----------------------------------------------------------------------
  Future<dynamic> delete(
      String uri, {
        // ignore: type_annotate_public_apis
        bool authRequired = false,
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: await headers(options?.headers ?? {}, authRequired),
        ),
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioError catch (e) {
      final exception = await _handleApiError(e);
      throw exception;
    }
  }

  // Put:----------------------------------------------------------------------
  Future<dynamic> put(
      String uri, {
        // ignore: type_annotate_public_apis
        bool authRequired = false,
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: await headers(options?.headers ?? {}, authRequired),
        ),
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      final exception = await _handleApiError(e);
      throw exception;
    }
  }
}
