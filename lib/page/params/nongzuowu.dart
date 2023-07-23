import 'package:app_nongye/page/params/nongzuowu_detail.dart';
import 'package:app_nongye/page/params/nongzuowu_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/NongzuowuController.dart';

class NongzuowuPage extends GetView<NongzuowuController> {
  NongzuowuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () =>
                Get.to(() => NongzuowuDetailPage(key: UniqueKey())),
            child: const Icon(Icons.add)),
        body: Obx(() => ListView(
              children: controller.datas
                  .map((e) =>
                      NongzuowuListItemPage(key: Key('${e['id']}'), data: e))
                  .toList(),
            )));
  }
}
