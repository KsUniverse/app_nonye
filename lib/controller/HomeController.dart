import 'package:app_nongye/controller/ParamsTabbarController.dart';
import 'package:app_nongye/page/params.dart';
import 'package:app_nongye/page/settings/jichucanshu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../page/yunxing.dart';

class HomeController extends GetxController {
  final currentTab = 0.obs;
  final pages =
      [ParamsPage(), YunxingPage(), JichucanshuPage(key: UniqueKey())].obs;

  @override
  void onInit() {
    super.onInit();
    Get.put(ParamsTabbarController());
    Get.put(YunxingTabbarController());
    Get.put(JichucanshuController());
    changeTab(null);
  }

  void changeTab(int? value) {
    pages[2] = JichucanshuPage(key: UniqueKey());
    currentTab.value = value ?? currentTab.value;
    switch (currentTab.value) {
      case 0:
        Get.find<ParamsTabbarController>().changeTabbar(0);
        break;
      case 1:
        Get.find<YunxingTabbarController>().changeTabbar(0);
        break;
      case 2:
        Get.find<JichucanshuController>().onInit();
        break;
    }
  }
}
