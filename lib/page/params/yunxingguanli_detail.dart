import 'package:app_nongye/api/business.dart';
import 'package:app_nongye/components/FormLine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YunxingguanliDetailPage extends GetView<YunxingguanliDetailController> {
  YunxingguanliDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(YunxingguanliDetailController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("编辑运行管理"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.black, fontSize: 16),
              child: Column(children: [
                FormLine(
                  label: "农作物",
                  labelStyle: const TextStyle(color: Colors.black54),
                  child: Text(controller.data['plant'],
                      style: const TextStyle(color: Colors.black54)),
                ),
                FormLine(
                  label: "生育期",
                  labelStyle: const TextStyle(color: Colors.black54),
                  child: Text(controller.data['syq'],
                      style: const TextStyle(color: Colors.black54)),
                ),
                FormLine(
                  label: "生育时长(天)",
                  child: TextFormField(
                    initialValue: "${controller.data['sc']}",
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onChanged: (value) => controller.data['sc'] = value,
                  ),
                ),
                FormLine(
                  label: "水分阈值(%)",
                  child: TextFormField(
                    initialValue: "${controller.data['sfyz']}",
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: InputBorder.none, isDense: true),
                    onChanged: (value) => controller.data['sfyz'] = value,
                  ),
                ),
                FormLine(
                  label: "湿润深度(cm)",
                  child: TextFormField(
                    initialValue: "${controller.data['srsd']}",
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: InputBorder.none, isDense: true),
                    onChanged: (value) => controller.data['srsd'] = value,
                  ),
                ),
                FormLine(
                  label: "氮分配比例(%)",
                  child: TextFormField(
                    initialValue: "${controller.data['nfpbili']}",
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: InputBorder.none, isDense: true),
                    onChanged: (value) => controller.data['nfpbili'] = value,
                  ),
                ),
                FormLine(
                  label: "磷氮养分比(%)",
                  child: TextFormField(
                    initialValue: "${controller.data['pnbili']}",
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: InputBorder.none, isDense: true),
                    onChanged: (value) => controller.data['pnbili'] = value,
                  ),
                ),
                FormLine(
                  label: "钾氮分配比(%)",
                  child: TextFormField(
                    initialValue: "${controller.data['knbili']}",
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: InputBorder.none, isDense: true),
                    onChanged: (value) => controller.data['knbili'] = value,
                  ),
                ),
                FormLine(
                    label: "初始含水量(%)",
                    child: Obx(() => DropdownMenu<String>(
                          inputDecorationTheme: const InputDecorationTheme(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              isDense: true),
                          onSelected: (value) =>
                              controller.data['syhsl'] = value,
                          initialSelection: controller.data['syhsl'],
                          dropdownMenuEntries: [
                            '60～70',
                            '70～75',
                            '75～80',
                            '80～90'
                          ]
                              .map((e) =>
                                  DropdownMenuEntry<String>(value: e, label: e))
                              .toList(),
                        ))),
                FormLine(
                    label: "最大施肥浓度(‰)",
                    child: Obx(() => DropdownMenu<double>(
                          inputDecorationTheme: const InputDecorationTheme(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              isDense: true),
                          onSelected: (value) =>
                              controller.data['sfnd'] = "$value",
                          initialSelection:
                              double.parse(controller.data['sfnd']),
                          dropdownMenuEntries: [
                            0.5,
                            0.6,
                            0.7,
                            0.8,
                            0.9,
                            1.0,
                            1.2,
                            1.5,
                            1.8,
                            2.0
                          ]
                              .map((e) => DropdownMenuEntry<double>(
                                  value: e, label: "$e"))
                              .toList(),
                        ))),
                FormLine(
                    label: "灌水器流量(升/小时)",
                    child: Obx(() => DropdownMenu<int>(
                          inputDecorationTheme: const InputDecorationTheme(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              isDense: true),
                          onSelected: (value) =>
                              controller.data['gsqll'] = value,
                          initialSelection: controller.data['gsqll'] ?? 2,
                          dropdownMenuEntries: [2, 4]
                              .map((e) =>
                                  DropdownMenuEntry<int>(value: e, label: "$e"))
                              .toList(),
                        ))),
                FormLine(
                  label: "灌溉时间(分钟)",
                  child: Text("${controller.data['runtime']}",
                      style: const TextStyle(color: Colors.black54)),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      child: const Text("保存"),
                      onPressed: () => controller.updateOne(),
                    ))
                  ],
                )
              ]),
            )));
  }
}

class YunxingguanliDetailController extends GetxController {
  final data = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    data.value = Get.arguments;
  }

  updateOne() async {
    await yunxingguanliUpdate(data);
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
