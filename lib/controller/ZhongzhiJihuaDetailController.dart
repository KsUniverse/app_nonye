import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/business.dart';

class ZhongzhiJihuaDetailController extends GetxController {
  final data = <String, dynamic>{}.obs;
  final TextEditingController lgzController = TextEditingController();

  ZhongzhiJihuaDetailController() : super() {
    data.addAll(Get.arguments);
  }

  updateOne() async {
    await zhongzhijihuaUpdate(data);
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
