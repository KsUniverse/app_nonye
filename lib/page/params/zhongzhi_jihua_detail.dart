import 'package:app_nongye/controller/ZhongzhiJihuaDetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/FormLine.dart';

@immutable
class ZhongzhiJihuaDetailPage extends GetView<ZhongzhiJihuaDetailController> {
  const ZhongzhiJihuaDetailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ZhongzhiJihuaDetailController controller =
        Get.put(ZhongzhiJihuaDetailController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("种植计划详情"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
            child: Column(children: [
              FormLine(
                  label: "种植单元",
                  labelStyle: const TextStyle(color: Colors.black54),
                  child: Text(
                    "${controller.data['zzdy']}",
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  )),
              const SizedBox(height: 10),
              FormLine(
                  label: "轮灌组",
                  child: Obx(() => DropdownMenu<int>(
                        key: Key("${controller.data['lgz']}"),
                        inputDecorationTheme: const InputDecorationTheme(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            isDense: true),
                        initialSelection:
                            int.parse("${controller.data['lgz']}"),
                        onSelected: (value) => controller.data['lgz'] = value,
                        controller: controller.lgzController,
                        dropdownMenuEntries: <int>[
                          1,
                          2,
                          3,
                          4,
                          5,
                          6,
                          7,
                          8,
                          9,
                          10
                        ]
                            .map((e) =>
                                DropdownMenuEntry<int>(value: e, label: "$e"))
                            .toList(),
                      ))),
              const SizedBox(height: 10),
              FormLine(
                  label: "是否种植",
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("是"),
                      Obx(() => Radio(
                          value: "是",
                          groupValue: "${controller.data['isplant']}",
                          onChanged: (value) {
                            controller.data['isplant'] = value;
                          })),
                      const Text("否"),
                      Obx(() => Radio(
                          value: "否",
                          groupValue: "${controller.data['isplant']}",
                          onChanged: (value) {
                            controller.data['isplant'] = value;
                          })),
                    ],
                  ))),
              const SizedBox(height: 10),
              FormLine(
                  label: "农作物",
                  child: TextFormField(
                    initialValue: "${controller.data['plant']}",
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onChanged: (value) => controller.data['plant'] = value,
                  )),
              const SizedBox(height: 10),
              FormLine(
                  label: "产量(kg/亩)",
                  child: Obx(() => TextFormField(
                        initialValue: "${controller.data['chanliang']}",
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        onChanged: (value) =>
                            controller.data['chanliang'] = value,
                      ))),
              const SizedBox(height: 10),
              FormLine(
                  label: "株数",
                  child: Obx(() => TextFormField(
                        initialValue: "${controller.data['area']}",
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        onChanged: (value) => controller.data['area'] = value,
                      ))),
              const SizedBox(height: 10),
              FormLine(
                  label: "种植密度(株/亩)",
                  child: Obx(() => TextFormField(
                        initialValue: "${controller.data['plantdensity']}",
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        onChanged: (value) =>
                            controller.data['plantdensity'] = value,
                      ))),
              const SizedBox(height: 10),
              FormLine(
                  label: "伤流时间",
                  child: Obx(() => InkWell(
                      child: Row(
                        children: [
                          Text("${controller.data['kssj']}"),
                          const Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      onTap: () => showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100))
                              .then((value) {
                            if (value != null) {
                              controller.data['kssj'] =
                                  "${value.month}月${value.day}日";
                            }
                          })))),
              const SizedBox(height: 10),
              FormLine(
                  label: "氮养分用量",
                  child: Obx(() => TextFormField(
                        initialValue: "${controller.data['tnl']}",
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        onChanged: (value) => controller.data['tnl'] = value,
                      ))),
              const SizedBox(height: 10),
              FormLine(
                  label: "磷养分用量",
                  labelStyle: const TextStyle(color: Colors.black54),
                  child: Obx(() => TextFormField(
                        initialValue: "${controller.data['tpl']}",
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        style: const TextStyle(color: Colors.black54),
                        onChanged: (value) => controller.data['tpl'] = value,
                      ))),
              const SizedBox(height: 10),
              FormLine(
                  label: "氮钾养分用量",
                  labelStyle: const TextStyle(color: Colors.black54),
                  child: Obx(() => TextFormField(
                        initialValue: "${controller.data['tkl']}",
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        style: const TextStyle(color: Colors.black54),
                        onChanged: (value) => controller.data['tkl'] = value,
                      ))),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () => controller.updateOne(),
                          child: const Text("保存")))
                ],
              )
            ])));
  }
}
