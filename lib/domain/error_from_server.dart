import 'package:g_json/g_json.dart';

class ErrorFromServer implements Exception {
  final bool error;
  final String message;
  final List<ErrorMessage> listErrorMessage;

  ErrorFromServer({
    this.error,
    this.message,
    this.listErrorMessage
  });

  // Error from Server
  factory ErrorFromServer.fromJson(Map<String, dynamic> json) {
    final jsonParser = JSON(json);
    return ErrorFromServer(
      error: jsonParser['error'].booleanValue,
      message: jsonParser['message'].stringValue,
      listErrorMessage: jsonParser['errorMessage'].listValue.map((e) => ErrorMessage.fromJson(e)).toList(),
    );
  }

  factory ErrorFromServer.unknownError() {
    return ErrorFromServer(
        error: true, message: 'Had Eror From Server');
  }

  factory ErrorFromServer.unAuthorize() {
    return ErrorFromServer(
        error: true,
        message: 'Session Invalid, Please login again');
  }
  factory ErrorFromServer.noInternetConnection() {
    return ErrorFromServer(
        error: true,
        message: 'Can\'t access internet, please check internet and try again');
  }
}

class ErrorMessage {
  final String field;
  final String message;

  ErrorMessage({this.field, this.message});

  factory ErrorMessage.fromJson(JSON json) {
    return ErrorMessage(
      field: json['field'].stringValue,
      message: json['message'].stringValue,
    );
  }
}
