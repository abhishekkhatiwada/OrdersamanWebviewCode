import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ordersaman/common/http/dio_retrier.dart';
import 'package:ordersaman/common/utils/custom_log.dart';

class DioClient {
  final Dio _dio = Dio();
  final String baseUrl;
  DioClient({required this.baseUrl}) {
    _dio
      ..httpClientAdapter
      ..options.responseType = ResponseType.json;

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false,
          request: true,
          requestBody: true,
        ),
      );
    }
  }

  Future<Response> get(
    Uri uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.getUri(
        uri,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      if (error is DioException) {
        switch (error.response?.statusCode) {
          case 401:
            return await requestRetrier(
              baseUrl: baseUrl,
              response: error.response!,
            );
          default:
            rethrow;
        }
      } else {
        rethrow;
      }
    }
  }

  Future<dynamic> post(
    Uri uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    CustomLog.action("===== REQUEST DATA =====");
    CustomLog.log(data);
    CustomLog.action("===== REQUEST DATA =====");
    FormData? formData;
    if (data is Map) formData = FormData.fromMap(Map.from(data));

    try {
      final response = await _dio.postUri(
        uri,
        data: formData ?? data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 401) {
        return await requestRetrier(baseUrl: baseUrl, response: response);
      }
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      CustomLog.log("Error caught");
      if (error is DioException) {
        switch (error.response?.statusCode) {
          case 401:
            final x = await requestRetrier(
              baseUrl: baseUrl,
              response: error.response!,
            );

            CustomLog.log("====== Issue Response ======");
            CustomLog.action(x);
            CustomLog.log("====== Issue Response ======");
            return x;
          default:
            rethrow;
        }
      } else {
        rethrow;
      }
    }
  }

  Future<dynamic> put(
    Uri uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.putUri(
        uri,
        data: data,
        // queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      if (error is DioException) {
        switch (error.response?.statusCode) {
          case 401:
            return await requestRetrier(
              baseUrl: baseUrl,
              response: error.response!,
            );
          default:
            rethrow;
        }
      } else {
        rethrow;
      }
    }
  }

  Future<dynamic> patch(
    Uri uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patchUri(
        uri,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      if (error is DioException) {
        switch (error.response?.statusCode) {
          case 401:
            return await requestRetrier(
              baseUrl: baseUrl,
              response: error.response!,
            );
          default:
            rethrow;
        }
      } else {
        rethrow;
      }
    }
  }

  Future<Response> delete(
    Uri uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.deleteUri(
        uri,
        // queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        data: data,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      if (error is DioException) {
        switch (error.response?.statusCode) {
          case 401:
            return await requestRetrier(
              baseUrl: baseUrl,
              response: error.response!,
            );
          default:
            rethrow;
        }
      } else {
        rethrow;
      }
    }
  }
}
