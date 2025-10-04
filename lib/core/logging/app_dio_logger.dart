import 'package:dio/dio.dart';

import 'app_logger.dart';

final class AppDioLogger extends Interceptor {
  const AppDioLogger(
    this.isIsolate, {
    this.requestBody = false,
  });
  final bool isIsolate;
  final bool requestBody;
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    logError(
      {
        'PATH': err.requestOptions.uri,
        'STATUS CODE': err.response?.statusCode,
        'DATA': err.response?.data,
        'MESSAGE': err.message,
        'RESPONSE ERROR:': err.response,
      },
      err,
      err.stackTrace,
    );

    super.onError(err, handler);
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    logInfo({
      'RESPONSE': response.requestOptions.uri,
      'STATUS CODE': response.statusCode,
      'DATA': response.data,
    });

    super.onResponse(response, handler);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final method = options.method;
    final path = options.uri.toString();
    final headers = options.headers;
    logInfo({
      'METHOD': method,
      'PATH': path,
      'HEADERS': headers,
      'QUERY PARAMETERS': options.queryParameters,
      if (requestBody) 'REQUEST BODY': options.data,
    });
    super.onRequest(options, handler);
  }
}
