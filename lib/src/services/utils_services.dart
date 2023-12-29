import 'package:app_quitanda/src/config/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:motion_toast/motion_toast.dart';

class UtilsServices {
  final storage = const FlutterSecureStorage();

  // Salva o dado localmente em segurança
  Future<void> saveLocalToken({required String key, required String data}) async {
    await storage.write(key: key, value: data);
  }

  // Recupera dado salvo localmente
  Future<String?> getLocalToken({required String key}) async {
    return await storage.read(key: key);
  }

  // Remove dado salvo localmente
  Future<void> removeLocalToken({required String key}) async {
    await storage.delete(key: key);
  }

  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: "pt_BR");

    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd("pt_BR").add_Hm();
    return dateFormat.format(dateTime);
  }

  void showToast({required String message, bool isError = false, required context}) {
    MotionToast(
      icon: isError ? Icons.info : Icons.check_circle,
      primaryColor: isError ? Colors.red : CustomColors.customSwatchColor,
      description: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
      width: 200,
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 40),
    ).show(context);
  }
}
