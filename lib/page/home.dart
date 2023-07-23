import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/HomeController.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
        body: Obx((() => controller.pages[controller.currentTab.value])),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              currentIndex: controller.currentTab.value,
              onTap: (value) => controller.changeTab(value),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.auto_awesome_mosaic_outlined),
                    label: '配置'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.access_time_rounded), label: '运行'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.app_registration), label: '系统参数'),
              ]),
        ));
  }
}
