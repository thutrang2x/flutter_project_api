// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.response,
    this.data,
  });

  Response response;
  Data data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        response: Response.fromJson(json["response"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.accountNo,
  });

  String accountNo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accountNo: json["accountNo"],
      );

  Map<String, dynamic> toJson() => {
        "accountNo": accountNo,
      };
}

class Response {
  Response({
    this.responseId,
    this.responseCode,
    this.responseMessage,
    this.responseTime,
  });

  String responseId;
  String responseCode;
  String responseMessage;
  DateTime responseTime;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        responseId: json["responseId"],
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        responseTime: DateTime.parse(json["responseTime"]),
      );

  Map<String, dynamic> toJson() => {
        "responseId": responseId,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "responseTime": responseTime.toIso8601String(),
      };
}
