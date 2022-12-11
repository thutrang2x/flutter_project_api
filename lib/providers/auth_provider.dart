import 'dart:async';
import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_regis_provider/domain/api_help.dart';
import 'package:flutter_login_regis_provider/model/request/login_request.dart';
import 'package:flutter_login_regis_provider/model/response/login_response.dart';
import 'package:flutter_login_regis_provider/utility/app_url.dart';
// import 'package:http/http.dart';
import 'package:pointycastle/asymmetric/api.dart';

import '../utility/utils.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get registeredInStatus => _registeredInStatus;

  set registeredInStatus(Status value) {
    _registeredInStatus = value;
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final Map<String, dynamic> apiBodyData = {
      'email': email,
      'password': password
    };

    // return await post(AppUrl.register,
    //         body: json.encode(apiBodyData),
    //         headers: {'Content-Type': 'application/json'})
    //     .then(onValue)
    //     .catchError(onError);
  }

  notify() {
    notifyListeners();
  }

  static Future<FutureOr> onValue(response) async {
    var result;

    // final Map<String, dynamic> responseData = json.decode(response.body);

    // print(responseData);

    // if (response.statusCode == 200) {
    //   var userData = responseData['data'];

    //   // now we will create a user model
    //   User authUser = User.fromJson(responseData);

    //   // now we will create shared preferences and save data
    //   UserPreferences().saveUser(authUser);

    //   result = {
    //     'status': true,
    //     'message': 'Successfully registered',
    //     'data': authUser
    //   };
    // } else {
    //   result = {
    //     'status': false,
    //     'message': 'Successfully registered',
    //     'data': responseData
    //   };
    // }
    return result;
  }

  Future<Map<String, dynamic>> login(String _username, String _password) async {
    var result;

    final dir = await rootBundle.loadString('pem_file/public.pem');

    print(dir);

    final rsaPublicKey = await RSAKeyParser().parse(dir) as RSAPublicKey;

    print(rsaPublicKey);

    final encrypter = Encrypter(RSA(publicKey: rsaPublicKey));
    /*final userNameEncrypted = encrypter.encrypt(_username);

    final passwordEncrypted = encrypter.encrypt(_password);*/

    final data = {
      "username": _username,
      "password": _password,
    };

    print(jsonEncode(data));

    final encryptedData = encrypter.encrypt(jsonEncode(data));

    print(encryptedData.base64);

    final Map<String, dynamic> loginData = {
      "data": {
        "credential": encryptedData.base64,
        "key":
            "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCDY1DzbqoavP8UVPYARHpy+zPlaFiBdf3imr5m4RdbHCwMueevk+NoWV2dqL/LBnk8oWMqWkgMDnTleXe/jvj6zQEuuCoBVDiZq4k0JXbHdTmXg0/fH7d9YD0BsSkpSJH8A9RBSnjvIzKLNHXKTUyxG1QIIKbU2lhVAB/jK2UtdwIDAQAB"
      },
      "request": {"requestTime": DateTime.now().toUtc().millisecondsSinceEpoch}
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    // Response response = await post(
    //   AppUrl.login,
    //   body: json.encode(loginData),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'access-token':
    //         'eyJraWQiOiJXcDRGMndiQVpMa1d2WWgyNDhnYjNtUHBLRzZTdDRNcG85Tmc3U2diZ2E0PSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiJkOTM2NmY3Yy02ZGJlLTRkZmUtOGZkNy1kMzA5MjM5YzUxNTUiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLmFwLXNvdXRoZWFzdC0xLmFtYXpvbmF3cy5jb21cL2FwLXNvdXRoZWFzdC0xX1FiMVE4VFBzVSIsImNvZ25pdG86dXNlcm5hbWUiOiJkOTM2NmY3Yy02ZGJlLTRkZmUtOGZkNy1kMzA5MjM5YzUxNTUiLCJvcmlnaW5fanRpIjoiMjcwNDI2YjgtYWU3MC00NTZiLWI1YzgtMDk1Yzg5NzY2NWVkIiwiYXVkIjoic2lrY25laTR0MmgzbnRrcWo1ZDQ5bHR2ciIsImV2ZW50X2lkIjoiYjAxODJmMzgtNDM5MC00MTdkLWI2N2EtNjIwNzE5NzVlMzI4IiwidG9rZW5fdXNlIjoiaWQiLCJhdXRoX3RpbWUiOjE2Njk3NDk3NzIsIm5hbWUiOiJBQkNBQSIsImV4cCI6MTY3MDc2OTU4OSwiaWF0IjoxNjcwNjgzMTg5LCJqdGkiOiI3ZjhlODRmZi03MTgxLTRlYzAtYmUxNS0xMmI0Y2JhMzI2NzQiLCJlbWFpbCI6InJlcGFybzEwOTJAdHVydW1hLmNvbSJ9.xP58T6y4o6GD73lEdRQIwL8LZuPekC36c9xbJ0GAIqzggcteJUYw3b-8Nlkz75z5UnE9MGHr8xL2VCGn1uqk0BLa9ZQtksFhkknGShHe-yVL7G__rRmC_1qQvvM2DBUHfZFu-FKpOMF140BMwSHQ3Delrx4fHMnN1qwdG_6ZD7KzdmVTj2Bn0iv58MKy0L35ZvXGn5UewFHXUdpFJn0n-tPJFyR3lyul7kxOBoHK8Y47Z355Ouh69IYrye6bNuRpo6x151OT4vb6Ip9KbLIs-GdoHXNt0gITJkIq2x73p2awfoeOEQLXNA2RsUSMP1n0R8gVcQPjPMU4FP7Qj7yaog',
    //     'x-api-key': 'hutech_hackathon@123456'
    //   },
    // );

    //   if (response.statusCode == 200) {
    //     final Map<String, dynamic> responseData = json.decode(response.body);

    //     print(responseData.toString());

    //     //var res = await json.decode((response.body));

    //     var authUser = User.fromJson(response);

    //     UserPreferences().saveUser(authUser);

    //     _loggedInStatus = Status.LoggedIn;

    //     notifyListeners();

    //     result = {
    //       'response': true,
    //       'responseMessage': 'Success',
    //       'user': authUser
    //     };
    //   } else {
    //     _loggedInStatus = Status.NotLoggedIn;
    //     notifyListeners();
    //     result = {
    //       'status': false,
    //       'message': json.decode(response.body)['error']
    //     };
    //     print("faild");
    //   }

    return result;
  }

  static onError(error) {
    print('the error is ${error.detail}');
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }

  Future<String> handleRenderEncrypter(String username, String password) async {
    final dir = await rootBundle.loadString('assets/pem_file/public.pem');
    final rsaPublicKey = await RSAKeyParser().parse(dir) as RSAPublicKey;
    final encrypter = Encrypter(RSA(publicKey: rsaPublicKey));
    final data = {
      "username": username,
      "password": password,
    };
    final encryptedData = encrypter.encrypt(jsonEncode(data));

    return encryptedData.base64;
  }

  Future<LoginResponse> hanldeLoginUser(
      String username, String password) async {
    try {
      // final dir = await rootBundle.loadString('pem_file/public.pem');
      String crendential = await handleRenderEncrypter(username, password);
      Crendential cre =
          Crendential(credential: crendential, key: Utils.publicKey);
      print(cre.credential);
      RequestLogin requestLoginParameter = RequestLogin(
          requestId: "",
          requestTime:
              DateTime.now().toUtc().millisecondsSinceEpoch.toString());
      LoginRequest request =
          LoginRequest(data: cre, request: requestLoginParameter);
      final loginResponse = await ApiHelper.postLogin(request);
      return loginResponse;
    } catch (error) {
      print(error.toString());
    }
    return null;
  }
}
