import 'package:app_nongye/components/FormLine.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../api/business.dart';

class JichucanshuPage extends GetView<JichucanshuController> {
  const JichucanshuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('基础参数设置')),
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Obx(() => ListView(children: [
                      ...controller.properitesList.map((e) {
                        return FormLine(
                            label:
                                "${e['paliasname']}${e['punit'] == '' ? '' : '(${e['punit']})'}",
                            labelFlex: 3,
                            child: switchFormField(e, context));
                      }).toList(),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.updateList();
                                },
                                child: const Text("保存")),
                          )
                        ],
                      ),
                      const SizedBox(height: 20)
                    ])))));
  }

  switchFormField(e, context) {
    switch (e['pname']) {
      case 'autoRun':
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("是"),
            Radio(
                value: "是",
                groupValue: "${e['pvalue']}",
                onChanged: (value) {
                  e['pvalue'] = value;
                  controller.properitesList.refresh();
                }),
            const Text("否"),
            Radio(
                value: "否",
                groupValue: "${e['pvalue']}",
                onChanged: (value) {
                  e['pvalue'] = value;
                  controller.properitesList.refresh();
                }),
          ],
        );
      case 'beginTime':
        return DateTimePicker(
          key: UniqueKey(),
          type: DateTimePickerType.dateTime,
          dateMask: 'yyyy/MM/dd HH:mm',
          locale: const Locale("zh", 'CN'),
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (newValue) {
            e['pvalue'] = newValue;
          },
          initialValue:
              DateFormat('yyyy/MM/dd HH:mm').parse(e['pvalue']).toString(),
          firstDate: DateTime(DateTime.now().year - 5),
          lastDate: DateTime(DateTime.now().year + 1),
        );
      case 'TRLX':
        return DropdownMenu(
          initialSelection: e['pvalue'],
          inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              isDense: true),
          onSelected: (value) => e['pvalue'] = value,
          dropdownMenuEntries: ['粘壤', '重壤', '中壤', '轻壤', '沙壤']
              .map((e) => DropdownMenuEntry(value: e, label: e))
              .toList(),
        );
    }
    return TextFormField(
      initialValue: "${e['pvalue']}",
      decoration: const InputDecoration(
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
      onChanged: (newValue) => e['pvalue'] = newValue,
    );
  }
}

class JichucanshuController extends GetxController {
  final properitesList = [].obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    properitesList.clear();
    systemProperitesList().then((value) {
      value['data'].forEach((element) {
        properitesList.add(element);
      });
    });
  }

  void updateList() async {
    await systemProperitesUpdate({'data': properitesList.toList()});
    Get.snackbar("提示", "保存成功");
    init();
  }
}
