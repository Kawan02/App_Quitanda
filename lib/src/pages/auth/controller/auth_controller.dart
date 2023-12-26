import 'package:app_quitanda/src/pages/auth/repository/auth_repository.dart';
import 'package:app_quitanda/src/pages/auth/result/auth_result.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final authRepository = AuthRepository();

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    AuthResult result = await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(
      success: (user) {
        print(user);
      },
      error: (message) {
        print(message);
      },
    );
  }
}
