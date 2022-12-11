import 'package:flutter_login_regis_provider/domain/base_api.dart';
import 'package:flutter_login_regis_provider/model/request/login_request.dart';
import 'package:flutter_login_regis_provider/model/response/login_response.dart';
import 'package:flutter_login_regis_provider/utility/app_url.dart';

class ApiHelper {
  static Future<LoginResponse> postLogin(LoginRequest body) async {
    try {
      var response = await HttpUtil().post(
        AppUrl.login,
        data: body,
        queryParameters: {
          "access-token":
              "eyJraWQiOiJXcDRGMndiQVpMa1d2WWgyNDhnYjNtUHBLRzZTdDRNcG85Tmc3U2diZ2E0PSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiJkOTM2NmY3Yy02ZGJlLTRkZmUtOGZkNy1kMzA5MjM5YzUxNTUiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLmFwLXNvdXRoZWFzdC0xLmFtYXpvbmF3cy5jb21cL2FwLXNvdXRoZWFzdC0xX1FiMVE4VFBzVSIsImNvZ25pdG86dXNlcm5hbWUiOiJkOTM2NmY3Yy02ZGJlLTRkZmUtOGZkNy1kMzA5MjM5YzUxNTUiLCJvcmlnaW5fanRpIjoiMjcwNDI2YjgtYWU3MC00NTZiLWI1YzgtMDk1Yzg5NzY2NWVkIiwiYXVkIjoic2lrY25laTR0MmgzbnRrcWo1ZDQ5bHR2ciIsImV2ZW50X2lkIjoiYjAxODJmMzgtNDM5MC00MTdkLWI2N2EtNjIwNzE5NzVlMzI4IiwidG9rZW5fdXNlIjoiaWQiLCJhdXRoX3RpbWUiOjE2Njk3NDk3NzIsIm5hbWUiOiJBQkNBQSIsImV4cCI6MTY3MDc2OTU4OSwiaWF0IjoxNjcwNjgzMTg5LCJqdGkiOiI3ZjhlODRmZi03MTgxLTRlYzAtYmUxNS0xMmI0Y2JhMzI2NzQiLCJlbWFpbCI6InJlcGFybzEwOTJAdHVydW1hLmNvbSJ9.xP58T6y4o6GD73lEdRQIwL8LZuPekC36c9xbJ0GAIqzggcteJUYw3b-8Nlkz75z5UnE9MGHr8xL2VCGn1uqk0BLa9ZQtksFhkknGShHe-yVL7G__rRmC_1qQvvM2DBUHfZFu-FKpOMF140BMwSHQ3Delrx4fHMnN1qwdG_6ZD7KzdmVTj2Bn0iv58MKy0L35ZvXGn5UewFHXUdpFJn0n-tPJFyR3lyul7kxOBoHK8Y47Z355Ouh69IYrye6bNuRpo6x151OT4vb6Ip9KbLIs-GdoHXNt0gITJkIq2x73p2awfoeOEQLXNA2RsUSMP1n0R8gVcQPjPMU4FP7Qj7yaog",
          "x-api-key": "hutech_hackathon@123456",
          "Content-Length": "<calculated when request is sent>",
          "Host": "<calculated when request is sent>",
          "Content-Type": "application/json"
        },
      );
      var resModel = LoginResponse.fromJson(response);
      return resModel;
    } catch (error) {
      print(error);
    }
  }
}
