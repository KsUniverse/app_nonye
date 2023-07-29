import 'package:app_nongye/components/FormLine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FuhepeihePage extends GetView<FuhepeifeiController> {
  @override
  Widget build(BuildContext context) {
    Get.put(FuhepeifeiController());
    return Scaffold(
        appBar: AppBar(title: const Text('复合肥配肥')),
        body: SafeArea(
            child: Container(
          child: ListView(
            children: [
              Row(children: [
                Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)))),
                        ),
                        onPressed: () {
                          controller.tabValue.value = 1;
                        },
                        child: const Text("配置参数"))),
                Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)))),
                        ),
                        onPressed: () {
                          controller.tabValue.value = 2;
                        },
                        child: const Text("配置结果"))),
              ]),
              const SizedBox(height: 10),
              Obx(() => Visibility(
                    visible: controller.tabValue.value == 1,
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Expanded(child: Text('养分名称')),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              '氮',
                              textAlign: TextAlign.center,
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              '磷',
                              textAlign: TextAlign.center,
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              '钾',
                              textAlign: TextAlign.center,
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text("养分含量%")),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                onChanged: (value) =>
                                    controller.datas['nd'] = value,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                onChanged: (value) =>
                                    controller.datas['ld'] = value,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                onChanged: (value) =>
                                    controller.datas['kd'] = value,
                              ),
                            ),
                          ],
                        ),
                        FormLine(
                            label: "计量元素",
                            child: Obx((() => DropdownMenu<String>(
                                  key: UniqueKey(),
                                  onSelected: (value) =>
                                      controller.datas['jlys'] = value,
                                  initialSelection:
                                      "${controller.datas['jlys'] ?? '氮'}",
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                          contentPadding: EdgeInsets.zero,
                                          border: InputBorder.none,
                                          isDense: true),
                                  dropdownMenuEntries: const [
                                    DropdownMenuEntry(label: "氮", value: '氮'),
                                    DropdownMenuEntry(label: "磷", value: '磷'),
                                    DropdownMenuEntry(label: "钾", value: '钾'),
                                  ],
                                )))),
                        FormLine(
                            label: "配肥桶",
                            child: Obx(() => DropdownMenu<String>(
                                  key: UniqueKey(),
                                  onSelected: (value) =>
                                      controller.datas['pft'] = value,
                                  initialSelection:
                                      "${controller.datas['pft'] ?? 'A'}",
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                          contentPadding: EdgeInsets.zero,
                                          border: InputBorder.none,
                                          isDense: true),
                                  dropdownMenuEntries: const [
                                    DropdownMenuEntry(label: "A", value: 'A'),
                                    DropdownMenuEntry(label: "B", value: 'B'),
                                    DropdownMenuEntry(label: "C", value: 'C'),
                                  ],
                                ))),
                        FormLine(
                            label: "溶解度%",
                            child: Obx(() => DropdownMenu<int>(
                                key: UniqueKey(),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none,
                                        isDense: true),
                                onSelected: (value) =>
                                    controller.datas['rjd'] = value,
                                initialSelection: controller.datas['rjd'] ?? 98,
                                dropdownMenuEntries: [
                                  91,
                                  92,
                                  93,
                                  94,
                                  95,
                                  96,
                                  97,
                                  98,
                                  99,
                                  100
                                ]
                                    .map((e) => DropdownMenuEntry<int>(
                                        value: e, label: "$e"))
                                    .toList()))),
                        FormLine(
                          label: "单价元/T",
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero),
                            onChanged: (value) =>
                                controller.datas['dj'] = value,
                          ),
                        ),
                        FormLine(
                            label: "配置浓度%",
                            child: Obx(() => DropdownMenu<num>(
                                key: UniqueKey(),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none,
                                        isDense: true),
                                onSelected: (value) =>
                                    controller.datas['pfnd'] = value,
                                initialSelection:
                                    controller.datas['pfnd'] ?? 17.1,
                                dropdownMenuEntries: [
                                  4.8,
                                  8.9,
                                  13,
                                  17.1,
                                  21.2,
                                  25.3,
                                  29.4,
                                  33.5,
                                  37.6,
                                  41.7
                                ]
                                    .map((e) => DropdownMenuEntry(
                                        value: e, label: "$e"))
                                    .toList()))),
                        FormLine(
                            label: "配置量/升",
                            child: Obx(() => DropdownMenu<int>(
                                key: UniqueKey(),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none,
                                        isDense: true),
                                onSelected: (value) =>
                                    controller.datas['pzl'] = value,
                                initialSelection:
                                    controller.datas['pzl'] ?? 400,
                                dropdownMenuEntries: [
                                  100,
                                  200,
                                  300,
                                  400,
                                  500,
                                  600,
                                  700,
                                  800,
                                  900,
                                  1000
                                ]
                                    .map((e) => DropdownMenuEntry(
                                        value: e, label: "$e"))
                                    .toList()))),
                        FormLine(
                            label: "肥料用量",
                            child: Obx(
                              () => Text("${controller.datas['flyl'] ?? '0'}"),
                            )),
                        FormLine(
                            label: "预计补水量",
                            child: Obx(
                              () => Text("${controller.datas['yjbsl'] ?? '0'}"),
                            )),
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: const Column(children: [
                            Text("营养液配置方法:"),
                            Text("A肥桶中添加: 复合肥68kg, 补水300升;"),
                            Text("总配置量400升"),
                            Text("运行前请保证充足的营养液供应"),
                          ]),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () => {}, child: const Text("确认"))
                      ],
                    ),
                  )),
              Obx(() => Visibility(
                    visible: controller.tabValue.value == 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child:
                                    Text("价格元/升", textAlign: TextAlign.center)),
                            Expanded(
                                child: Text("氮养分g/l",
                                    textAlign: TextAlign.center)),
                            Expanded(
                                child: Text("磷养分g/l",
                                    textAlign: TextAlign.center)),
                            Expanded(
                                child: Text("钾养分g/l",
                                    textAlign: TextAlign.center)),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child:
                                    Text("0.1", textAlign: TextAlign.center)),
                            Expanded(
                                child:
                                    Text("0.1", textAlign: TextAlign.center)),
                            Expanded(
                                child:
                                    Text("0.1", textAlign: TextAlign.center)),
                            Expanded(
                                child:
                                    Text("0.1", textAlign: TextAlign.center)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          color: Colors.black12,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          padding: EdgeInsets.all(10),
                          child: Column(children: [
                            Row(
                              children: [
                                Expanded(child: Text("轮罐组")),
                                Expanded(child: Text("灌溉量")),
                                Expanded(child: Text("运行时间")),
                                Expanded(child: Text("操作类型")),
                                Expanded(child: Text("计划期氮")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text("1")),
                                Expanded(child: Text("17.52吨")),
                                Expanded(child: Text("90分钟")),
                                Expanded(child: Text("灌溉施肥")),
                                Expanded(child: Text("29.81kg")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text("2")),
                                Expanded(child: Text("17.52吨")),
                                Expanded(child: Text("90分钟")),
                                Expanded(child: Text("灌溉施肥")),
                                Expanded(child: Text("29.81kg")),
                              ],
                            )
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 40),
                          child: const Column(children: [
                            Text("运行时间: 180分钟"),
                            SizedBox(height: 5),
                            Text("肥料用量: 35.93kg"),
                            SizedBox(height: 5),
                            Text("灌溉量: 35.93吨"),
                            SizedBox(height: 5),
                            Text("施肥浓度: 1‰"),
                            SizedBox(height: 5),
                            Text("营养液用量: 210升"),
                            SizedBox(height: 5),
                            Text("施肥时间: 24分钟"),
                            SizedBox(height: 5),
                            Text("肥料价格: 0.07元"),
                          ]),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        )));
  }
}

class FuhepeifeiController extends GetxController {
  RxMap<String, dynamic> datas = <String, dynamic>{}.obs;
  final tabValue = 1.obs;
}
