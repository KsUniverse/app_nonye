import 'package:app_nongye/page/params/zhongzhi_jihua_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/ZhongzhiJihuaController.dart';

@immutable
class ListItemPage extends GetView {
  final Map<String, dynamic> data;

  const ListItemPage({
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
                      Get.to(() => const ZhongzhiJihuaDetailPage(),
                              arguments: data)!
                          .then((value) {
                        if (value != null) {
                          Get.find<ZhongzhiJihuaController>().onInit();
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
                                "种植区: ${data['zzdy']}",
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
                                      child: Text("轮灌组: ${data['lgz']}"),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text("农作物: ${data['plant']}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child:
                                            Text("是否种植: ${data['isplant']}")),
                                    Expanded(
                                        flex: 1,
                                        child: Text("伤流时间: ${data['kssj']}"))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child:
                                          Text("数量(株): ${data['chanliang']}"),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          "产量(kg/亩): ${data['chanliang']}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          "种植密度(株/亩): ${data['plantdensity']}"),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text("产物: ${data['chanwu']}"),
                                    ),
                                  ],
                                ),
                              ]),
                            )),
                      ],
                    )))));
  }
}
