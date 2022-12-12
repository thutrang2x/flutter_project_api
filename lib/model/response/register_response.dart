// // To parse this JSON data, do
// //
// //     final loginResponse = loginResponseFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// RegisterResponse loginResponseFromJson(String str) =>
//     RegisterResponse.fromJson(json.decode(str));

// String loginResponseToJson(RegisterResponse data) => json.encode(data.toJson());

// class RegisterResponse {
//   RegisterResponse({
//     this.response,
//     this.data,
//   });

//   Response response;
//   Data data;

//   factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
//       RegisterResponse(
//         response: Response.fromJson(json["response"]),
//         data: Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "response": response.toJson(),
//         "data": data.toJson(),
//       };
// }

// class Data {
//   Data({
//     this.accountNo,
//   });

//   String accountNo;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         accountNo: json["accountNo"],
//       );

//   Map<String, dynamic> toJson() => {
//         "accountNo": accountNo,
//       };
// }

// class Response {
//   Response({
//     this.responseId,
//     this.responseCode,
//     this.responseMessage,
//     this.responseTime,
//   });

//   String responseId;
//   String responseCode;
//   String responseMessage;
//   DateTime responseTime;

//   factory Response.fromJson(Map<String, dynamic> json) => Response(
//         responseId: json["responseId"],
//         responseCode: json["responseCode"],
//         responseMessage: json["responseMessage"],
//         responseTime: DateTime.parse(json["responseTime"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "responseId": responseId,
//         "responseCode": responseCode,
//         "responseMessage": responseMessage,
//         "responseTime": responseTime.toIso8601String(),
//       };
// }

// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.response,
    this.data,
  });

  Response response;
  Data data;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
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
    this.userId,
  });

  String userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
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
