import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart' as parse;
import 'package:ordersaman/common/http/dio_client.dart';
import 'package:ordersaman/common/http/dio_exception.dart';
import 'package:ordersaman/common/utils/custom_log.dart';
import 'package:ordersaman/common/utils/device_utils.dart';

class ApiProvider {
  final String baseUrl;

  ApiProvider({required this.baseUrl});

  Future<Map<String, dynamic>> post(
    String url,
    dynamic body, {
    String token = '',
    bool isRefreshRequest = false,
    Map<String, String> header = const {},
  }) async {
    dynamic responseJson;
    final DioClient dioClient = DioClient(baseUrl: baseUrl);

    try {
      final Map<String, String> requestHeader = {
        'content-type': 'application/x-www-form-encoded',
        'accept': 'application/json',
        'origin': '*',
        ...header,
        ...await DeviceUtils.deviceInfoHeader,
      };

      if (token.isNotEmpty) {
        requestHeader['Authorization'] = 'Bearer $token';
      }
      final dynamic response = await dioClient.post(
        Uri.parse(url),
        data: body,
        options: Options(headers: requestHeader),
      );
      responseJson = _response(response, url);
    } on DioException catch (e) {
      CustomLog.log(e);
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  Future<dynamic> patch(
    String url,
    dynamic body, {
    String token = '',
    bool isRefreshRequest = false,
  }) async {
    final DioClient dioClient = DioClient(baseUrl: baseUrl);

    dynamic responseJson;
    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
        ...await DeviceUtils.deviceInfoHeader,
      };
      if (token.isNotEmpty) {
        header['Authorization'] = 'Bearer $token';
      }
      final dynamic response = await dioClient.patch(
        Uri.parse(url),
        data: body,
        options: Options(headers: header),
      );
      responseJson = _response(response, url);
    } on DioException catch (e) {
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  Future<dynamic> put(
    String url,
    dynamic body, {
    String token = '',
    bool isRefreshRequest = false,
  }) async {
    final DioClient dioClient = DioClient(baseUrl: baseUrl);

    dynamic responseJson;
    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
        ...await DeviceUtils.deviceInfoHeader,
      };
      if (token.isNotEmpty) {
        header['Authorization'] = 'Bearer $token';
      }
      final dynamic response = await dioClient.put(
        Uri.parse(url),
        data: body,
        options: Options(headers: header),
      );
      responseJson = _response(response, url);
    } on DioException catch (e) {
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  Future<dynamic> get(
    Uri url, {
    String token = '',
    bool isRefreshRequest = false,
    Duration timeOut = const Duration(milliseconds: 30),
  }) async {
    final DioClient dioClient = DioClient(baseUrl: baseUrl);

    dynamic responseJson;

    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
        ...await DeviceUtils.deviceInfoHeader,
      };

      if (token.isNotEmpty) {
        header['Authorization'] = 'Bearer $token';
      }
      final dynamic response = await dioClient.get(
        url,
        options: Options(
          headers: header,
          sendTimeout: timeOut * 1000,
          receiveTimeout: timeOut * 1000,
        ),
      );

      responseJson = _response(response, url.toString(), cacheResult: true);
    } on DioException catch (e, s) {
      responseJson = await _handleErrorResponse(e);
      CustomLog.log(e);
      CustomLog.action(s);
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, {String token = '', dynamic body}) async {
    final DioClient dio = DioClient(baseUrl: baseUrl);
    dynamic responseJson;
    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
        ...await DeviceUtils.deviceInfoHeader,
      };
      debugPrint('TOKEN $token');
      if (token.isNotEmpty) {
        header['Authorization'] = 'Bearer $token';
      }
      final dynamic response = await dio.delete(
        Uri.parse(url),
        data: body,
        options: Options(headers: header),
      );
      responseJson = await _response(response, url);
      responseJson['status'] = response.statusCode;
    } on DioException catch (e) {
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  upload(String url, File file, {String token = ''}) async {
    final DioClient dio = DioClient(baseUrl: baseUrl);
    dynamic responseJson;
    try {
      final Map<String, String> header = {
        'accept': 'application/json',
        'origin': '*',
        ...await DeviceUtils.deviceInfoHeader,
      };
      if (token.isNotEmpty) {
        header['Authorization'] = 'Bearer $token';
      }
      final String fileName = file.path.split('/').last;
      // final String _extention = file.path.split('.').last;
      //final String type = lookupMimeType(file.path)!.split('/').first;

      final FormData formData = FormData.fromMap(<String, dynamic>{
        'image': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: parse.MediaType('image', file.path.split('.').last),
        ),
      });
      final Response<dynamic> response = await dio.post(
        Uri.parse(url),
        data: formData,
        options: Options(headers: header),
        onSendProgress: (count, total) {},
      );

      responseJson = _response(response, url);
    } on DioException catch (e) {
      responseJson = await _handleErrorResponse(e);
      CustomLog.log(e);
    }
    return responseJson;
  }

  Future<File?> download(
    String url,
    String localPath, {
    required int userId,
    required String token,
  }) async {
    final DioClient dio = DioClient(baseUrl: baseUrl);
    try {
      final Map<String, String> header = {
        'accept': 'application/json',
        'origin': '*',
        ...await DeviceUtils.deviceInfoHeader,
      };

      if (token.isNotEmpty) {
        header['Authorization'] = 'Bearer $token';
      }

      final Response<dynamic> response = await dio.get(
        Uri.parse(url),
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          headers: header,
          validateStatus: (status) {
            if (status == null) {
              return false;
            }
            return status < 500;
          },
        ),
      );
      if (response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final File file = File(localPath);
          final raf = file.openSync(mode: FileMode.write);
          raf.writeFromSync(response.data);
          await raf.close();
          return file;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on DioException catch (e) {
      CustomLog.log(e);

      // responseJson = await _handleErrorResponse(e);
      return null;
    } catch (e) {
      CustomLog.log("ERROR WHILE DOWNLOADING");

      return null;
    }
  }

  _handleErrorResponse(DioException e) async {
    if (e.toString().toLowerCase().contains("socketexception")) {
      throw NoInternetException('No Internet connection', 1000);
    } else {
      if (e.response != null) {
        return await _response(e.response!, "");
      } else {
        throw FetchDataException(
          'An error occurred while fetching data.',
          e.response?.statusCode,
        );
      }
    }
  }

  Future<Map<String, dynamic>> _response(
    Response response,
    String url, {
    bool cacheResult = false,
  }) async {
    String responseStr = "";
    final Map<String, dynamic> res =
        response.data is Map
            ? response.data
            : (response.data is List)
            ? {"data": response.data}
            : {};
    if (response.data is String) {
      responseStr = response.data;
    }

    final responseJson = <String, dynamic>{};
    responseJson['data'] = res;
    if (responseStr.isNotEmpty) {
      responseJson['data'] = responseStr;
    }

    responseJson['statusCode'] = response.statusCode;
    switch (response.statusCode) {
      case 200:
        if (cacheResult) {
          try {
            // await SharedPref.setRestApiData(url, json.encode(res));
          } catch (e) {
            CustomLog.log(e);
          }
        }

        return responseJson;
      case 204:
        return responseJson;
      case 201:
        return responseJson;
      case 400:
        throw BadRequestException(
          getErrorMessage(res, 400),
          response.statusCode,
        );
      case 404:
        throw ResourceNotFoundException(
          getErrorMessage(res, 404),
          response.statusCode,
        );
      case 422:
        responseJson['error'] = getErrorMessage(res, response.statusCode);
        throw BadRequestException(
          getErrorMessage(res, 404),
          response.statusCode,
        );
      case 429:
        responseJson['error'] = getErrorMessage(res, response.statusCode);
        throw BadRequestException(
          "You've made too many requests. Please try again after a while.",
          response.statusCode,
        );
      case 401:
      case 403:
        throw UnauthorisedException(
          getErrorMessage(res, 404),
          response.statusCode,
        );
      case 500:
        throw InternalServerErrorException(
          getErrorMessage(res, 404),
          response.statusCode,
        );

      // This is server base  must change according to server Specific Custom Server Exception with any specific message on Gateway level blockage.
      case 506:
        throw CustomServerException(
          jsonDecode(response.data)['message'] ??
              "Feature not available. Please check back again.",
          response.statusCode,
        );
      default:
        throw NoInternetException(
          'Error occured while Communication with Server',
          1000,
        );
    }
  }

  String getErrorMessage(dynamic res, [int? statusCode]) {
    String message = "";
    try {
      CustomLog.log(res);
      debugPrint("-------------------GET ERROR ------------------");
      if (res["data"] is Map) {
        if (res["data"]?["message"] is String &&
            (res["data"]?["message"] ?? "").toString().isNotEmpty) {
          message = res["data"]?["message"];
          return message;
        }
      }
      if (res["message"] is String) {
        message = res["message"];
        return message;
      }
      if (res["message"] is List) {
        final List<dynamic> messages = res['message'][0]["messages"];
        for (var element in messages) {
          message += (element as Map<String, dynamic>)['message'] + '\n';
        }
        return message;
      }
      if (res["data"] is String) {
        message = res["data"] ?? "";
      }
    } catch (e) {
      return message.isEmpty
          ? _getErroMessageAccordingtoStatusCode(statusCode)
          : message;
    }
    return message.isEmpty
        ? _getErroMessageAccordingtoStatusCode(statusCode)
        : message;
  }

  String _getErroMessageAccordingtoStatusCode(int? statusCode) {
    if (statusCode == 400) {
      return "Bad Request";
    } else if (statusCode == 404) {
      return "Resource Not Found";
    } else if (statusCode == 422) {
      return "Bad Request";
    } else if (statusCode == 403 || statusCode == 402 || statusCode == 401) {
      return "Unauthorized";
    } else if (statusCode == 500) {
      return "Internal Server Error";
    } else {
      return "Something went wrong";
    }
  }
}
