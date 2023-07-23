import 'package:app_nongye/controller/NongzuowuController.dart';
import 'package:app_nongye/page/params/nongzuowu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../page/params/yunxingguihua.dart';
import '../page/params/yunxinguanli.dart';
import '../page/params/zhongzhi_jihua.dart';
import 'ZhongzhiJihuaController.dart';

class ParamsTabbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> tabs = const [
    Tab(text: "种植计划"),
    Tab(text: "农作物"),
    Tab(text: "运行管理"),
    Tab(text: "运行规划")
  ];
  final List<Widget> tabbars = [
    ZhongzhiJihuaPage(),
    NongzuowuPage(),
    YunxingguanliPage(),
    YunxingguihuaPage(),
  ];
  late TabController tabController = TabController(length: 4, vsync: this);

  @override
  void onInit() {
    Get.put(ZhongzhiJihuaController());
    Get.put(NongzuowuController());
    Get.put(YunxingguanliController());
    Get.put(YunxingguihuaController());
    super.onInit();
  }

  changeTabbar(int? value) {
    tabController.index = value ?? tabController.index;
    switch (tabController.index) {
      case 0:
        Get.find<ZhongzhiJihuaController>().init();
        break;
      case 1:
        Get.find<NongzuowuController>().init();
        break;
      case 2:
        Get.find<YunxingguanliController>().init();
        break;
      case 3:
        Get.find<YunxingguihuaController>().init();
        break;
    }
  }
}
