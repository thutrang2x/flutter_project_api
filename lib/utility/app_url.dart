import '../domain/base_api.dart';

class AppUrl {
  static const String baseUrl =
      'https://7ucpp7lkyl.execute-api.ap-southeast-1.amazonaws.com/dev';

  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot_password';
}

enum ApiURL {
  register,
  login,
}

extension ApiURLState on ApiURL {
  String get path {
    switch (this) {
      case ApiURL.login:
        return AppUrl.login;
      case ApiURL.register:
        return AppUrl.register;
      default:
        return '';
    }
  }

  HTTPRequestMethods get methods {
    switch (this) {
      //- API Using Get Method

      //- API Using Post Method
      case ApiURL.login:
      case ApiURL.register:
        return HTTPRequestMethods.post;

      //- API Using Patch Method
      //  case ApiURL.updateProfile:

      // case ApiURL.cancelBookingHistory:
      //   return HTTPRequestMethods.delete;
      default:
        return null;
    }
  }
}
