import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_login_regis_provider/utility/app_url.dart';
import 'dart:io';

import 'error_from_server.dart';

enum HTTPRequestMethods { get, post, patch, delete }

class DioProvider {
  static Dio instance() {
    final dio = Dio()
      ..options.baseUrl = AppUrl.baseUrl
      ..options.connectTimeout = 300000
      ..options.receiveTimeout = 300000
      ..interceptors.add(HttpLogInterceptor());
    return dio;
  }
}

class HttpLogInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers = {
      "access-token":
          "eyJraWQiOiJXcDRGMndiQVpMa1d2WWgyNDhnYjNtUHBLRzZTdDRNcG85Tmc3U2diZ2E0PSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiJkOTM2NmY3Yy02ZGJlLTRkZmUtOGZkNy1kMzA5MjM5YzUxNTUiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLmFwLXNvdXRoZWFzdC0xLmFtYXpvbmF3cy5jb21cL2FwLXNvdXRoZWFzdC0xX1FiMVE4VFBzVSIsImNvZ25pdG86dXNlcm5hbWUiOiJkOTM2NmY3Yy02ZGJlLTRkZmUtOGZkNy1kMzA5MjM5YzUxNTUiLCJvcmlnaW5fanRpIjoiMjcwNDI2YjgtYWU3MC00NTZiLWI1YzgtMDk1Yzg5NzY2NWVkIiwiYXVkIjoic2lrY25laTR0MmgzbnRrcWo1ZDQ5bHR2ciIsImV2ZW50X2lkIjoiYjAxODJmMzgtNDM5MC00MTdkLWI2N2EtNjIwNzE5NzVlMzI4IiwidG9rZW5fdXNlIjoiaWQiLCJhdXRoX3RpbWUiOjE2Njk3NDk3NzIsIm5hbWUiOiJBQkNBQSIsImV4cCI6MTY3MDc2OTU4OSwiaWF0IjoxNjcwNjgzMTg5LCJqdGkiOiI3ZjhlODRmZi03MTgxLTRlYzAtYmUxNS0xMmI0Y2JhMzI2NzQiLCJlbWFpbCI6InJlcGFybzEwOTJAdHVydW1hLmNvbSJ9.xP58T6y4o6GD73lEdRQIwL8LZuPekC36c9xbJ0GAIqzggcteJUYw3b-8Nlkz75z5UnE9MGHr8xL2VCGn1uqk0BLa9ZQtksFhkknGShHe-yVL7G__rRmC_1qQvvM2DBUHfZFu-FKpOMF140BMwSHQ3Delrx4fHMnN1qwdG_6ZD7KzdmVTj2Bn0iv58MKy0L35ZvXGn5UewFHXUdpFJn0n-tPJFyR3lyul7kxOBoHK8Y47Z355Ouh69IYrye6bNuRpo6x151OT4vb6Ip9KbLIs-GdoHXNt0gITJkIq2x73p2awfoeOEQLXNA2RsUSMP1n0R8gVcQPjPMU4FP7Qj7yaog",
      "x-api-key": "hutech_hackathon@123456",
      "Content-Type": "application/json"
    };
    if (kDebugMode) {
      log('onRequest: ${options.headers}');
      log('onRequest: ${options.method}');
      log('onRequest: ${options.data}');
    }
    return handler.next(options);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    if (kDebugMode) {
      log('onRequest: ${response.realUri}');
      log('onResponse: $response');
    }
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      log('onError: $err\n'
          'Response: ${err.response}');
    }
    return super.onError(err, handler);
  }
}

class APIDataStore {
  Dio dio = DioProvider.instance();

  APIDataStore();

  // Public Request API
  Future<dynamic> requestAPI(ApiURL apiURL,
      {Map<String, dynamic> params,
      Map<String, dynamic> body,
      FormData formData,
      String customUrl}) async {
    dynamic bodyRequest;
    if (body != null) {
      bodyRequest = jsonEncode(body);
    } else if (formData != null) {
      bodyRequest = formData;
    }
    try {
      Response response;
      switch (apiURL.methods) {
        case HTTPRequestMethods.get:
          response = await dio.get(apiURL.path, queryParameters: params);
          break;
        case HTTPRequestMethods.post:
          response = await dio.post(apiURL.path,
              queryParameters: params, data: bodyRequest);
          break;
        case HTTPRequestMethods.patch:
          response = await dio.patch(customUrl ?? apiURL.path,
              queryParameters: params, data: bodyRequest);
          break;
        case HTTPRequestMethods.delete:
          response = await dio.delete(apiURL.path,
              queryParameters: params, data: bodyRequest);
          break;
        default:
          log('Không có methods được tạo');
          break;
      }

      if (response.data['error'] == true) {
        // if (response.data['MessageCode'] == 1111) {
        //   throw ErrorFromServer.unAuthorize();
        // }
        throw ErrorFromServer.unknownError();
      }
      return response.data;
    } on SocketException catch (_) {
      throw ErrorFromServer.noInternetConnection();
    } on DioError catch (e) {
      if (e.response != null) {
        throw ErrorFromServer.fromJson(e.response.data);
      } else {
        throw ErrorFromServer.unknownError();
      }
    }
  }
}
