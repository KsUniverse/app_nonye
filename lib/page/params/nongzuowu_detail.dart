import 'package:app_nongye/components/FormLine.dart';
import 'package:app_nongye/controller/NongzuowuDetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

@immutable
class NongzuowuDetailPage extends GetView<NongzuowuDetailController> {
  const NongzuowuDetailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    NongzuowuDetailController controller = Get.put(NongzuowuDetailController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(controller.isNew.value ? "新增农作物" : "编辑农作物"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
            child: DefaultTextStyle(
                style: const TextStyle(color: Colors.black, fontSize: 16),
                child: Column(
                  children: [
                    FormLine(
                        label: "作物",
                        labelStyle: controller.isNew.value
                            ? null
                            : const TextStyle(color: Colors.black54),
                        child: TextFormField(
                          onChanged: (value) =>
                              controller.data['zuowu'] = value,
                          initialValue: controller.data['zuowu'],
                          readOnly: !controller.isNew.value,
                          style: controller.isNew.value
                              ? null
                              : const TextStyle(color: Colors.black54),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: "请输入作物",
                          ),
                        )),
                    const FormLine(
                        label: "种类",
                        labelStyle: TextStyle(color: Colors.black54),
                        child: Text("果树",
                            style: TextStyle(color: Colors.black54))),
                    const SizedBox(height: 10),
                    const FormLine(
                        label: "产物",
                        labelStyle: TextStyle(color: Colors.black54),
                        child: Text("果实(鲜重)",
                            style: TextStyle(color: Colors.black54))),
                    FormLine(
                        label: "氮养分需要量(kg)",
                        child: TextFormField(
                          initialValue: controller.data['n'],
                          onChanged: (value) => controller.data['n'] = value,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: "请输入百公斤产量氮养分需要量(kg)",
                          ),
                        )),
                    FormLine(
                        label: "磷养分需要量(kg)",
                        child: TextFormField(
                          initialValue: controller.data['p2o5'],
                          onChanged: (value) => controller.data['p2o5'] = value,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: "请输入百公斤产量磷养分需要量(kg)",
                          ),
                        )),
                    FormLine(
                        label: "钾养分需要量(kg)",
                        child: TextFormField(
                          initialValue: controller.data['k2o'],
                          onChanged: (value) => controller.data['k2o'] = value,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: "请输入百公斤产量钾养分需要量(kg)",
                          ),
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () => controller.updateOne(),
                                child: const Text("保存")))
                      ],
                    )
                  ],
                ))));
  }
}
