// ignore_for_file: library_prefixes

import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart' as DioLib;
import 'package:flutter/material.dart';
import 'package:flutter_login_regis_provider/utility/app_url.dart';
import 'package:http/http.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  DioLib.Dio _dio;
  Map<String, dynamic> headers;

  HttpUtil._internal() {
    DioLib.BaseOptions options = DioLib.BaseOptions(
      baseUrl: AppUrl.baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 30000,
      headers: {
        "access-token":
            "eyJraWQiOiJXcDRGMndiQVpMa1d2WWgyNDhnYjNtUHBLRzZTdDRNcG85Tmc3U2diZ2E0PSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiJkOTM2NmY3Yy02ZGJlLTRkZmUtOGZkNy1kMzA5MjM5YzUxNTUiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLmFwLXNvdXRoZWFzdC0xLmFtYXpvbmF3cy5jb21cL2FwLXNvdXRoZWFzdC0xX1FiMVE4VFBzVSIsImNvZ25pdG86dXNlcm5hbWUiOiJkOTM2NmY3Yy02ZGJlLTRkZmUtOGZkNy1kMzA5MjM5YzUxNTUiLCJvcmlnaW5fanRpIjoiMjcwNDI2YjgtYWU3MC00NTZiLWI1YzgtMDk1Yzg5NzY2NWVkIiwiYXVkIjoic2lrY25laTR0MmgzbnRrcWo1ZDQ5bHR2ciIsImV2ZW50X2lkIjoiYjAxODJmMzgtNDM5MC00MTdkLWI2N2EtNjIwNzE5NzVlMzI4IiwidG9rZW5fdXNlIjoiaWQiLCJhdXRoX3RpbWUiOjE2Njk3NDk3NzIsIm5hbWUiOiJBQkNBQSIsImV4cCI6MTY3MDc2OTU4OSwiaWF0IjoxNjcwNjgzMTg5LCJqdGkiOiI3ZjhlODRmZi03MTgxLTRlYzAtYmUxNS0xMmI0Y2JhMzI2NzQiLCJlbWFpbCI6InJlcGFybzEwOTJAdHVydW1hLmNvbSJ9.xP58T6y4o6GD73lEdRQIwL8LZuPekC36c9xbJ0GAIqzggcteJUYw3b-8Nlkz75z5UnE9MGHr8xL2VCGn1uqk0BLa9ZQtksFhkknGShHe-yVL7G__rRmC_1qQvvM2DBUHfZFu-FKpOMF140BMwSHQ3Delrx4fHMnN1qwdG_6ZD7KzdmVTj2Bn0iv58MKy0L35ZvXGn5UewFHXUdpFJn0n-tPJFyR3lyul7kxOBoHK8Y47Z355Ouh69IYrye6bNuRpo6x151OT4vb6Ip9KbLIs-GdoHXNt0gITJkIq2x73p2awfoeOEQLXNA2RsUSMP1n0R8gVcQPjPMU4FP7Qj7yaog",
        "x-api-key": "hutech_hackathon@123456",
        "Content-Length": "<calculated when request is sent>",
        "Host": "<calculated when request is sent>"
      },
      contentType: 'application/json; charset=utf-8',
      responseType: DioLib.ResponseType.json,
    );
    _dio = DioLib.Dio(options);
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // CookieJar cookieJar = CookieJar();
    // _dio.interceptors.add(CookieManager(cookieJar));
  }

  void setToken(String token) {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
  }

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic> queryParameters,
    DioLib.Options options,
    DioLib.CancelToken cancelToken,
    DioLib.ProgressCallback onReceiveProgress,
  }) async {
    bool _isConnected = await _checkConnection();
    try {
      final DioLib.Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      response.requestOptions.uri;

      return response.data;
    } on DioLib.DioError catch (e) {
      rethrow;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic> queryParameters,
    DioLib.Options options,
    DioLib.CancelToken cancelToken,
    DioLib.ProgressCallback onSendProgress,
    DioLib.ProgressCallback onReceiveProgress,
  }) async {
    try {
      final DioLib.Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      print("request post: ${response.data}");
      return response.data;
    } on DioLib.DioError catch (e) {
      List<String> listResult = [];
      String result = "";
      if (e.response?.data["message"] is! String) {
        result = listResult.join();
      }
      if (e.response?.statusCode == 422) {
      } else if (e.response?.statusCode == 404) {
      } else if (e.response?.statusCode == 522 ||
          e.response?.statusCode == 408) {
      } else if (e.response?.statusCode == 500) {
      } else if (e.response?.statusCode == 401) {
      } else {}
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Put:----------------------------------------------------------------------
  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic> queryParameters,
    DioLib.Options options,
    DioLib.CancelToken cancelToken,
    DioLib.ProgressCallback onSendProgress,
    DioLib.ProgressCallback onReceiveProgress,
  }) async {
    try {
      final DioLib.Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioLib.DioError catch (e) {
      List<String> listResult = [];
      String result = "";
      e.response?.data["message"].forEach((key, value) {});
      result = listResult.join();
      // if (e.response?.statusCode == 422) {
      //   Get.defaultDialog(
      //       title: "Thông báo",
      //       content: Text(
      //           result.isEmpty
      //               ? "Lỗi khi nhập sai thông tin yêu cầu!!!"
      //               : result,
      //           textAlign: TextAlign.center),
      //       textCancel: "OK");
      // } else if (e.response?.statusCode == 404) {
      //   Get.defaultDialog(
      //       title: "Thông báo",
      //       content: const Text("Yêu cầu không tìm thấy!",
      //           textAlign: TextAlign.center),
      //       textCancel: "OK");
      // } else if (e.response?.statusCode == 522 ||
      //     e.response?.statusCode == 408) {
      //   Get.defaultDialog(
      //       title: "Thông báo",
      //       content: const Text("Quá thời gian kết nối!",
      //           textAlign: TextAlign.center),
      //       textCancel: "OK");
      // } else if (e.response?.statusCode == 500) {
      //   Get.defaultDialog(
      //       title: "Thông báo",
      //       content: const Text("Internal Server Error",
      //           textAlign: TextAlign.center),
      //       textCancel: "OK");
      // } else if (e.response?.statusCode == 401) {
      //   Get.defaultDialog(
      //       title: "Thông báo",
      //       content: const Text("Số điện thoại hoặc mật khẩu không đúng",
      //           textAlign: TextAlign.center),
      //       textCancel: "OK");
      // } else {
      //   Get.defaultDialog(
      //       title: "Thông báo",
      //       content:
      //           const Text("Quá thời gian kết nối.\n Vui lòng thử lại sau!", textAlign: TextAlign.center),
      //       textCancel: "OK");
      // }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE:----------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic> queryParameters,
    DioLib.Options options,
    DioLib.CancelToken cancelToken,
    DioLib.ProgressCallback onSendProgress,
    DioLib.ProgressCallback onReceiveProgress,
  }) async {
    try {
      final DioLib.Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioLib.DioError catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Download:------------------------------------------------------------------
  Future<dynamic> download(String uri, savePath,
      {data,
      Map<String, dynamic> queryParameters,
      DioLib.Options options,
      DioLib.CancelToken cancelToken,
      DioLib.ProgressCallback onSendProgress,
      DioLib.ProgressCallback onReceiveProgress,
      bool deleteOnError = true,
      String lengthHeader = DioLib.Headers.contentLengthHeader}) async {
    try {
      bool _isConnected = await _checkConnection();

      final DioLib.Response response = await _dio.download(uri, savePath,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          deleteOnError: deleteOnError,
          lengthHeader: lengthHeader);
      return response.data;
    } on DioLib.DioError catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  //The test to actually see if there is a connection
  Future<bool> _checkConnection() async {
    bool _isConnected = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isConnected = true;
      } else {
        _isConnected = false;
      }
    } on SocketException catch (_) {
      _isConnected = false;
    }

    return _isConnected;
  }
}
