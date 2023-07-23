import 'package:app_nongye/api/loginApi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../database/login_data.dart';
import '../utils/Logger.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final username = ''.obs;
  final password = ''.obs;

  void login() {
    loginApi(username.value, password.value).then((value) {
      if (value['error_description'] != null) {
        Get.snackbar("登录失败", value['error_description'],
            snackPosition: SnackPosition.TOP);
        return;
      }
      SharePreferenceRepository().loginSave(value);
      Get.toNamed("/home");
    }).catchError((err) {
      logger.e("err: $err");
      Get.snackbar("登录失败", err.toString(), snackPosition: SnackPosition.TOP);
    });
  }
}
