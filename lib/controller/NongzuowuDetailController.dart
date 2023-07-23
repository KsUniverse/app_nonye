import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/business.dart';

class NongzuowuDetailController extends GetxController {
  final data = <String, dynamic>{}.obs;
  final TextEditingController lgzController = TextEditingController();
  final isNew = false.obs;

  NongzuowuDetailController() : super() {
    if (Get.arguments != null) {
      data.addAll(Get.arguments);
    } else {
      isNew.value = true;
    }
  }

  updateOne() async {
    data['zhonglei'] = "果树";
    data['chanwu'] = "果实(鲜重)";
    await nongzuowuUpdate(data);
    Get.snackbar(
      "更新成功",
      "更新成功",
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 1),
      snackbarStatus: (status) => {
        if (status == SnackbarStatus.CLOSED)
          {Navigator.of(Get.overlayContext!, rootNavigator: true).pop(true)}
      },
    );
  }
}
