import 'package:app_nongye/network/network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import 'interceptors/authorization_interceptor.dart';
import 'interceptors/logger_interceptor.dart';

class DioClient {
  static DioClient? _instance;
  static DioClient? get instance => _getInstance();

  static DioClient _getInstance() {
    _instance ??= DioClient._internal();
    return _instance!;
  }

  DioClient._internal() {
    _init();
  }

  factory DioClient() => _getInstance();

  late Dio _dio;

  _init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseURL,
        connectTimeout:
            const Duration(milliseconds: Endpoints.connectionTimeout),
        receiveTimeout: const Duration(milliseconds: Endpoints.receiveTimeout),
        responseType: ResponseType.json,
      ),
    )..interceptors.addAll([
        AuthorizationInterceptor(),
        LoggerInterceptor(),
      ]);
  }

  Future<Map<String, dynamic>> request(String url,
      {String? method,
      Map<String, dynamic>? data,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers}) async {
    try {
      Response response = await _dio.request(url,
          data: data,
          queryParameters: params,
          options: Options(method: method, headers: headers));
      return response.data;
    } on DioException catch (err) {
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }
}
