import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/business.dart';
import 'danzipeifei.dart';
import 'fuhepeifei.dart';

class ZidongyunxingPage extends GetView<ZidongyunxingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GetBuilder<ZidongyunxingController>(
            builder: (controller) => FloatingActionButton(
                  backgroundColor:
                      controller.datas.any((element) => element['isrun'] == '是')
                          ? Colors.blue
                          : Colors.grey,
                  onPressed:
                      controller.datas.any((element) => element['isrun'] == '是')
                          ? () async {
                              int result = await showDialog(
                                context: context,
                                builder: (_) => SimpleDialog(
                                  title: Text("配肥方式"),
                                  children: [
                                    SimpleDialogOption(
                                      onPressed: () {
                                        Navigator.pop(context, 1);
                                      },
                                      child: const Text('复合肥配肥'),
                                    ),
                                    SimpleDialogOption(
                                      onPressed: () {
                                        Navigator.pop(context, 2);
                                      },
                                      child: const Text('单质肥配肥'),
                                    ),
                                  ],
                                ),
                              );
                              if (result == 1) {
                                Get.to(() => FuhepeihePage());
                              } else if (result == 2) {
                                Get.to(() => DanzipeifeiPage());
                              }
                            }
                          : null,
                  child: Text("配肥",
                      style: TextStyle(
                        color: controller.datas
                                .any((element) => element['isrun'] == '是')
                            ? Colors.white
                            : Colors.white54,
                      )),
                )),
        body: Obx(() => ListView.builder(
            itemCount: controller.datas.length,
            itemBuilder: (context, index) =>
                GetBuilder<ZidongyunxingController>(
                  builder: (controller) => ZidongyunxingListItemPage(
                    data: controller.datas[index],
                    onChanged: (value) {
                      controller.datas[index]['isrun'] = value ? '是' : '否';
                      controller.update();
                    },
                  ),
                ))));
  }
}

class ZidongyunxingController extends GetxController {
  final datas = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  init() {
    datas.clear();
    zidongyunxingList().then((value) {
      value['data'].forEach((element) {
        datas.add(element);
      });
    });
  }
}

class ZidongyunxingListItemPage extends GetView {
  final Map<String, dynamic> data;
  final ValueChanged onChanged;

  const ZidongyunxingListItemPage({
    Key? key,
    required this.data,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: IntrinsicHeight(
            child: Card(
                color: const Color.fromRGBO(248, 248, 248, 1),
                child: GestureDetector(
                    onTap: () {},
                    child: Row(children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            constraints: const BoxConstraints(minHeight: 100),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    "轮罐组: ${data['lgz']}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "种植单元: ${data['zzdy']}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Expanded(
                          flex: 4,
                          child: Container(
                              constraints: const BoxConstraints(minHeight: 100),
                              padding: const EdgeInsets.only(
                                  left: 20, top: 10, bottom: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text("施肥浓度(‰): ${data['sfnd']}"),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              const Text("是否运行: "),
                                              Expanded(
                                                  child: Checkbox(
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      value:
                                                          '${data['isrun']}' ==
                                                              '是',
                                                      onChanged: (value) {
                                                        onChanged(value);
                                                      }))
                                            ],
                                          ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text("作物: ${data['zzpz']}"),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text("生育期: ${data['period']}"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child:
                                            Text("湿润深度(cm): ${data['srsd']}"),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child:
                                            Text("数量(株): ${data['shuliang']}"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text("土壤湿度(%): ${data['sd']}"),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text("水分阈值: ${data['sfyz']}"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text("操作类型: ${data['czlx']}"),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text("灌溉量(吨): ${data['ggl']}"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text("运行时间: ${data['runtime']}"),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text("计划氮(kg): ${data['jhqn']}"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text("计划磷(kg): ${data['jhqp']}"),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text("计划钾(kg): ${data['jhqk']}"),
                                      )
                                    ],
                                  ),
                                ],
                              )))
                    ])))));
  }
}
