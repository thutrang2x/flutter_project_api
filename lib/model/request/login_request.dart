// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';

LoginRequest loginRequestFromJson(String str) =>
    LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  LoginRequest({
    this.data,
    this.request,
  });

  Crendential data;
  RequestLogin request;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        data: Crendential.fromJson(json["data"]),
        request: RequestLogin.fromJson(json["request"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "request": request.toJson(),
      };
}

class Crendential {
  Crendential({
    this.credential,
    this.key,
  });

  String credential;
  String key;

  factory Crendential.fromJson(Map<String, dynamic> json) => Crendential(
        credential: json["credential"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "credential": credential,
        "key": key,
      };
}

class RequestLogin {
  RequestLogin({
    this.requestId,
    this.requestTime,
  });

  String requestId;
  String requestTime;

  factory RequestLogin.fromJson(Map<String, dynamic> json) => RequestLogin(
        requestId: json["requestId"],
        requestTime: json["requestTime"],
      );

  Map<String, dynamic> toJson() => {
        "requestId": requestId,
        "requestTime": requestTime,
      };
}
