// // To parse this JSON data, do
// //
// //     final loginRequest = loginRequestFromJson(jsonString);

// import 'dart:convert';

// RegisterRequest loginRequestFromJson(String str) =>
//     RegisterRequest.fromJson(json.decode(str));

// String loginRequestToJson(RegisterRequest data) => json.encode(data.toJson());

// class RegisterRequest {
//   RegisterRequest({
//     this.data,
//     this.request,
//   });

//   CrendentialRegister data;
//   RequestRegister request;

//   factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
//       RegisterRequest(
//         data: CrendentialRegister.fromJson(json["data"]),
//         request: RequestRegister.fromJson(json["request"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data.toJson(),
//         "request": request.toJson(),
//       };
// }

// class CrendentialRegister {
//   CrendentialRegister({
//     this.credential,
//     this.key,
//   });

//   String credential;
//   String key;

//   factory CrendentialRegister.fromJson(Map<String, dynamic> json) =>
//       CrendentialRegister(
//         credential: json["credential"],
//         key: json["key"],
//       );

//   Map<String, dynamic> toJson() => {
//         "credential": credential,
//         "key": key,
//       };
// }

// class RequestRegister {
//   RequestRegister({
//     this.requestId,
//     this.requestTime,
//   });

//   String requestId;
//   String requestTime;

//   factory RequestRegister.fromJson(Map<String, dynamic> json) =>
//       RequestRegister(
//         requestId: json["requestId"],
//         requestTime: json["requestTime"],
//       );

//   Map<String, dynamic> toJson() => {
//         "requestId": requestId,
//         "requestTime": requestTime,
//       };
// }

// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromJson(jsonString);

import 'dart:convert';

RegisterRequest registerRequestFromJson(String str) =>
    RegisterRequest.fromJson(json.decode(str));

String registerRequestToJson(RegisterRequest data) =>
    json.encode(data.toJson());

class RegisterRequest {
  RegisterRequest({
    this.data,
    this.request,
  });

  CrendentialRegister data;
  RequestRegister request;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        data: CrendentialRegister.fromJson(json["data"]),
        request: RequestRegister.fromJson(json["request"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "request": request.toJson(),
      };
}

class CrendentialRegister {
  CrendentialRegister({
    this.credential,
    this.email,
    this.fullName,
    this.identityNumber,
    this.key,
    this.phone,
  });

  String credential;
  String email;
  String fullName;
  String identityNumber;
  String key;
  String phone;

  factory CrendentialRegister.fromJson(Map<String, dynamic> json) =>
      CrendentialRegister(
        credential: json["credential"],
        email: json["email"],
        fullName: json["fullName"],
        identityNumber: json["identityNumber"],
        key: json["key"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "credential": credential,
        "email": email,
        "fullName": fullName,
        "identityNumber": identityNumber,
        "key": key,
        "phone": phone,
      };
}

class RequestRegister {
  RequestRegister({
    this.requestId,
    this.requestTime,
  });

  String requestId;
  String requestTime;

  factory RequestRegister.fromJson(Map<String, dynamic> json) =>
      RequestRegister(
        requestId: json["requestId"],
        requestTime: json["requestTime"],
      );

  Map<String, dynamic> toJson() => {
        "requestId": requestId,
        "requestTime": requestTime,
      };
}
