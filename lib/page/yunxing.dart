import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'yunxing/zidongyunxing.dart';

class YunxingPage extends GetView<YunxingTabbarController> {
  @override
  Widget build(BuildContext context) {
    YunxingTabbarController controller = Get.put(YunxingTabbarController());
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 10,
          bottom: TabBar(
            isScrollable: true,
            controller: controller.tabController,
            tabs: controller.tabs,
            onTap: (value) => controller.changeTabbar(value),
          ),
        ),
        body: TabBarView(
            controller: controller.tabController,
            children: controller.tabbars));
  }
}

class YunxingTabbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> tabs = const [
    Tab(text: "自动运行"),
    Tab(text: "补充运行"),
    Tab(text: "中微量肥料"),
    Tab(text: "内吸性农药"),
    Tab(text: "计时运行")
  ];
  final List<Widget> tabbars = [
    ZidongyunxingPage(),
    ZidongyunxingPage(),
    ZidongyunxingPage(),
    ZidongyunxingPage(),
    ZidongyunxingPage(),
  ];

  late TabController tabController = TabController(length: 5, vsync: this);

  @override
  void onInit() {
    Get.put(ZidongyunxingController());
    Get.put(ZidongyunxingController());
    Get.put(ZidongyunxingController());
    Get.put(ZidongyunxingController());
    Get.put(ZidongyunxingController());
    super.onInit();
  }

  changeTabbar(int? value) {
    tabController.index = value ?? tabController.index;
    switch (tabController.index) {
      case 0:
        Get.find<ZidongyunxingController>().onInit();
        break;
      case 1:
        Get.find<ZidongyunxingController>().onInit();
        break;
      case 2:
        Get.find<ZidongyunxingController>().onInit();
        break;
      case 3:
        Get.find<ZidongyunxingController>().onInit();
        break;
      case 4:
        Get.find<ZidongyunxingController>().onInit();
        break;
    }
  }
}
