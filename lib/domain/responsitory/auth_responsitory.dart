import 'package:flutter_login_regis_provider/domain/base_api.dart';
import 'package:flutter_login_regis_provider/model/request/login_request.dart';
import 'package:flutter_login_regis_provider/model/response/login_response.dart';

import '../../utility/app_url.dart';

class AuthenticationRes {
  APIDataStore apiDataStore = APIDataStore();

  Future<LoginResponse> loginWithEmailPassword(LoginRequest params) async {
    final response =
        await apiDataStore.requestAPI(ApiURL.login, body: params.toJson());
    return LoginResponse.fromJson(response);
  }
}
