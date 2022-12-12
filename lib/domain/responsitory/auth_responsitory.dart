import 'package:flutter_login_regis_provider/domain/base_api.dart';
import 'package:flutter_login_regis_provider/model/request/login_request.dart';
import 'package:flutter_login_regis_provider/model/request/register_request.dart';
import 'package:flutter_login_regis_provider/model/response/login_response.dart';
import 'package:flutter_login_regis_provider/model/response/register_response.dart';
import 'package:flutter_login_regis_provider/screens/register.dart';

import '../../utility/app_url.dart';

class AuthenticationRes {
  APIDataStore apiDataStore = APIDataStore();

  Future<LoginResponse> loginWithEmailPassword(LoginRequest params) async {
    final response =
        await apiDataStore.requestAPI(ApiURL.login, body: params.toJson());
    return LoginResponse.fromJson(response);
  }

  Future<RegisterResponse> registerWithUserPassword(
      RegisterRequest params) async {
    final response =
        await apiDataStore.requestAPI(ApiURL.register, body: params.toJson());
    return RegisterResponse.fromJson(response);
  }
}
