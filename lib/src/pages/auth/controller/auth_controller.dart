import 'package:app_quitanda/src/constants/storage_keys.dart';
import 'package:app_quitanda/src/models/user_model.dart';
import 'package:app_quitanda/src/pages/auth/repository/auth_repository.dart';
import 'package:app_quitanda/src/pages/auth/result/auth_result.dart';
import 'package:app_quitanda/src/pages_routes/app_pages.dart';
import 'package:app_quitanda/src/services/utils_services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final authRepository = AuthRepository();
  final utilServices = UtilsServices();
  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    if (!GetPlatform.isWeb) {
      validateToken();
    }
  }

  Future<void> validateToken() async {
    String? token = await utilServices.getLocalToken(key: StorageKey.keyToken);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.sigInRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> signOut() async {
    // Zerar o user
    user = UserModel();

    // Remover o token salvo localmente
    await utilServices.removeLocalToken(key: StorageKey.keyToken);

    // Ir para o login
    Get.offAllNamed(PagesRoutes.sigInRoute);
  }

  void saveTokenAndProceedToBase() {
    // Salva o token
    utilServices.saveLocalToken(key: StorageKey.keyToken, data: user.token!);

    // Ir para a home
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading.value = true;

    AuthResult result = await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilServices.showToast(message: message, context: context, isError: true);
      },
    );
  }
}
