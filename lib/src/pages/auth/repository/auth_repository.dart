import 'package:app_quitanda/src/constants/endpoints.dart';
import 'package:app_quitanda/src/models/user_model.dart';
import 'package:app_quitanda/src/pages/auth/repository/auth_erros.dart' as auth_errors;
import 'package:app_quitanda/src/pages/auth/result/auth_result.dart';
import 'package:app_quitanda/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.validateToken,
      method: HttpMethods.post,
      headers: {
        "X-Parse-Session-Token": token,
      },
    );

    if (result["result"] != null) {
      final user = UserModel.fromJson(result["result"]);

      return AuthResult.success(user);
    }
    return AuthResult.error(auth_errors.authErrorsString(result["error"]));
  }

  Future<AuthResult> signIn({required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.signin,
      method: HttpMethods.post,
      body: {
        "email": email,
        "password": password,
      },
    );
    if (result["result"] != null) {
      final user = UserModel.fromJson(result["result"]);

      return AuthResult.success(user);
    }
    return AuthResult.error(auth_errors.authErrorsString(result["error"]));
  }
}
