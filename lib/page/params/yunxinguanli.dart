import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/business.dart';
import 'yunxingguanli_detail.dart';

class YunxingguanliPage extends GetView<YunxingguanliController> {
  YunxingguanliPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(YunxingguanliController());
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(children: [
              SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      const Expanded(flex: 1, child: Text("农作物:")),
                      Expanded(
                          flex: 2,
                          child: Obx(() => DropdownMenu<String>(
                                key: UniqueKey(),
                                initialSelection: "${controller.currentPlant}",
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none,
                                        isDense: true),
                                dropdownMenuEntries: controller.datas
                                    .map((element) => element['plant'])
                                    .toSet()
                                    .map((e) => DropdownMenuEntry<String>(
                                          value: e,
                                          label: e,
                                        ))
                                    .toList(),
                                onSelected: (value) =>
                                    controller.changeDataList(value),
                              ))),
                    ],
                  )),
              Container(
                height: 10,
                decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12))),
              ),
              Expanded(
                  child: Obx(() => ListView(
                      children: controller.datas
                          .where((p0) =>
                              p0['plant'] == controller.currentPlant.value)
                          .map((e) => YunxingguanliListItemPage(data: e))
                          .toList())))
            ])));
  }
}

class YunxingguanliController extends GetxController {
  final datas = <Map<String, dynamic>>[].obs;
  var currentPlant = "".obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  init() {
    datas.clear();
    yunxingguanliList().then((value) {
      value['data'].forEach((element) {
        datas.add(element);
      });
      if (currentPlant.value.isEmpty) {
        currentPlant.value = datas[0]['plant'];
      }
    });
  }

  changeDataList(String? value) {
    currentPlant.value = value ?? datas[0]['plant'];
  }
}

class YunxingguanliListItemPage extends GetView {
  final Map<String, dynamic> data;

  const YunxingguanliListItemPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: IntrinsicHeight(
            child: Card(
                color: const Color.fromRGBO(248, 248, 248, 1),
                child: GestureDetector(
                    onTap: () {
                      Get.to(() => YunxingguanliDetailPage(), arguments: data)!
                          .then((value) {
                        if (value != null) {
                          Get.find<YunxingguanliController>().onInit();
                        }
                      });
                    },
                    child: Row(children: [
                      SizedBox(
                        width: 100,
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 100),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "生育期: ${data['syq']}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            constraints: const BoxConstraints(minHeight: 100),
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, bottom: 10),
                            child: Column(children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text("灌溉时间(分钟): ${data['runtime']}"),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text("时长(天): ${data['sc']}"),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text("氮分配比例(%): ${data['nfpbili']}"),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text("施肥浓度(‰): ${data['sfnd']}"),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text("磷氮比: ${data['knbili']}"),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text("钾氮比: ${data['pnbili']}"),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text("水分阈值: ${data['sfyz']}"),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text("湿润深度(cm): ${data['srsd']}"),
                                  ),
                                ],
                              ),
                            ])),
                      )
                    ])))));
  }
}
