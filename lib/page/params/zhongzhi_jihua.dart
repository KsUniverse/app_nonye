import 'package:app_nongye/page/params/zhongzhi_jihua_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/ZhongzhiJihuaController.dart';

class ZhongzhiJihuaPage extends GetView<ZhongzhiJihuaController> {
  ZhongzhiJihuaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => ListView(
              children: controller.datas
                  .map((e) => ListItemPage(key: Key('${e['zzdy']}'), data: e))
                  .toList(),
            )));
  }
}
