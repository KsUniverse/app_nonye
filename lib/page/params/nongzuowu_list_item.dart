import 'package:app_nongye/controller/NongzuowuController.dart';
import 'package:app_nongye/page/params/nongzuowu_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

@immutable
class NongzuowuListItemPage extends GetView {
  final Map<String, dynamic> data;

  const NongzuowuListItemPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: IntrinsicHeight(
            child: Card(
                color: const Color.fromRGBO(248, 248, 248, 1),
                child: GestureDetector(
                    onTap: () {
                      Get.to(() => const NongzuowuDetailPage(),
                              arguments: data)!
                          .then((value) {
                        if (value != null) {
                          Get.find<NongzuowuController>().onInit();
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 100),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "作物: ${data['zuowu']}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Container(
                              constraints: const BoxConstraints(minHeight: 100),
                              padding: const EdgeInsets.only(
                                  left: 20, top: 10, bottom: 10),
                              child: Column(children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text("种类: ${data['zhonglei']}"),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text("产物: ${data['chanwu']}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child:
                                            Text("钾养分用量(kg): ${data['k2o']}")),
                                  ],
                                ),
                                Row(children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text("氮养分用量(kg): ${data['n']}")),
                                ]),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child:
                                            Text("磷养分用量(kg): ${data['p2o5']}")),
                                  ],
                                ),
                              ]),
                            )),
                      ],
                    )))));
  }
}
