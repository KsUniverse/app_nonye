import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ParamsTabbarController.dart';

class ParamsPage extends GetView<ParamsTabbarController> {
  @override
  Widget build(BuildContext context) {
    ParamsTabbarController controller = Get.put(ParamsTabbarController());
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 10,
          bottom: TabBar(
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
