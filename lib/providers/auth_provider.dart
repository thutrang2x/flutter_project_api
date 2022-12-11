import 'dart:async';
import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_regis_provider/domain/responsitory/auth_responsitory.dart';
import 'package:flutter_login_regis_provider/model/request/login_request.dart';
import 'package:flutter_login_regis_provider/model/response/login_response.dart';
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
  notify() {
    notifyListeners();
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
      final loginResponse =
          await AuthenticationRes().loginWithEmailPassword(request);
      return loginResponse;
    } catch (error) {
      print(error.toString());
    }
    return null;
  }
}
