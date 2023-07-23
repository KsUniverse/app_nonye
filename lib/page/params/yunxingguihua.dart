import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../api/business.dart';

class YunxingguihuaPage extends GetView<YunxingguihuaController> {
  @override
  Widget build(BuildContext context) {
    Get.put(YunxingguihuaController());
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(children: [
              SizedBox(
                  child: Column(children: [
                Row(
                  children: [
                    const Expanded(flex: 1, child: Text("种植区:")),
                    Expanded(
                        flex: 2,
                        child: Obx(() => DropdownMenu<int>(
                              key: UniqueKey(),
                              initialSelection: controller.currentZzdy.value,
                              inputDecorationTheme: const InputDecorationTheme(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  isDense: true),
                              dropdownMenuEntries: controller.zzdyList.map((e) {
                                return DropdownMenuEntry<int>(
                                    value: e, label: "$e");
                              }).toList(),
                              onSelected: (value) =>
                                  controller.changeDataList(value),
                            ))),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Obx(() => Text(
                          "作物: ${controller.currentData.isNotEmpty ? controller.currentData[0]['plant'] : ''}")),
                    ),
                    Expanded(
                        flex: 1,
                        child: Obx(() => Text(
                            "当前运行期: ${controller.currentsysj['syq'] ?? '无'}"))),
                  ],
                )
              ])),
              const SizedBox(height: 10),
              Container(
                height: 10,
                decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12))),
              ),
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
                        child: const Text("数据"))),
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
                        child: const Text("图表"))),
              ]),
              const SizedBox(height: 20),
              Obx(() => Visibility(
                  visible: controller.tabValue.value == 1,
                  child: Expanded(child: YunxingguihuaListDataPage()))),
              Obx(() => Visibility(
                  visible: controller.tabValue.value == 2,
                  child: Expanded(child: YunxingguihuaChartsPage()))),
            ])));
  }
}

class YunxingguihuaController extends GetxController {
  final datas = <Map<String, dynamic>>[].obs;
  final zzdyList = <int>[].obs;
  final currentData = <Map<String, dynamic>>[].obs;
  final currentZzdy = 0.obs;
  final currentsysj = {}.obs;

  final table1Data = <BarChartGroupData>[].obs;
  final table2Data = <BarChartGroupData>[].obs;
  final table3Data = <BarChartGroupData>[].obs;
  final table4Data = <BarChartGroupData>[].obs;
  final tabValue = 1.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  init() {
    datas.clear();
    zzdyList.clear();

    yunxingguihuaList().then((value) {
      value['data'].forEach((element) {
        datas.add(element);
      });
      var dataList = datas
          .map((element) => int.parse("${element['zzdy']}"))
          .toSet()
          .toList();
      dataList.sort();
      zzdyList.addAll(dataList);
      if (currentZzdy.value == 0) {
        changeDataList(zzdyList[0]);
      }
    });
  }

  changeDataList(int? value) {
    currentZzdy.value = value!;
    currentData.clear();
    currentData.addAll(datas.where((element) => element['zzdy'] == value));
    currentData.sort((a, b) => a['id'].compareTo(b['id']));
    var startKssj = currentData[0]['kssj'];
    var date = DateFormat('MM月dd日').parse(startKssj);
    date = DateTime(DateTime.now().year, date.month, date.day);
    currentData.forEach((one) {
      one['startKssj'] = DateFormat('yyyy年MM月dd日').format(date);
      var endDate = date.add(const Duration(days: 100));
      one['endKssj'] = DateFormat('yyyy年MM月dd日').format(endDate);
      if (DateTime.now().isBefore(endDate) && DateTime.now().isAfter(date)) {
        currentsysj.value = one;
      }
      date = endDate;
    });
    initTable1Data();
    initTable2Data();
    initTable3Data();
    initTable4Data();
  }

  void initTable1Data() {
    table1Data.clear();
    for (int i = 0; i < 4; i++) {
      table1Data.add(BarChartGroupData(x: i, barsSpace: 8, barRods: [
        BarChartRodData(
          toY: 15,
          color: Colors.red,
          width: 15,
          borderRadius: const BorderRadius.all(Radius.zero),
        ),
        BarChartRodData(
          toY: 10,
          color: Colors.green,
          width: 15,
          borderRadius: const BorderRadius.all(Radius.zero),
        ),
        BarChartRodData(
          toY: 18,
          color: Colors.blue,
          width: 15,
          borderRadius: const BorderRadius.all(Radius.zero),
        ),
      ]));
    }
  }

  void initTable2Data() {
    table2Data.clear();
    for (int i = 0; i < 4; i++) {
      table2Data.add(BarChartGroupData(x: i, barsSpace: 20, barRods: [
        BarChartRodData(
          toY: 15,
          color: Colors.red,
          width: 60,
          borderRadius: const BorderRadius.all(Radius.zero),
        ),
      ]));
    }
  }

  void initTable3Data() {
    table3Data.clear();
    for (int i = 0; i < 4; i++) {
      table3Data.add(BarChartGroupData(x: i, barsSpace: 20, barRods: [
        BarChartRodData(
          toY: 15,
          color: Colors.red,
          width: 60,
          borderRadius: const BorderRadius.all(Radius.zero),
        ),
      ]));
    }
  }

  void initTable4Data() {
    table4Data.clear();
    for (int i = 0; i < 4; i++) {
      table4Data.add(BarChartGroupData(x: i, barsSpace: 20, barRods: [
        BarChartRodData(
          toY: 15,
          color: Colors.red,
          width: 60,
          borderRadius: const BorderRadius.all(Radius.zero),
        ),
      ]));
    }
  }
}

class YunxingguihuaListDataPage extends GetView {
  @override
  Widget build(BuildContext context) {
    YunxingguihuaController controller = Get.find<YunxingguihuaController>();
    return Obx(() => ListView(
          children: controller.currentData.map((data) {
            return Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: IntrinsicHeight(
                    child: Card(
                        color: const Color.fromRGBO(248, 248, 248, 1),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Container(
                                constraints:
                                    const BoxConstraints(minHeight: 100),
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
                                flex: 4,
                                child: Container(
                                  constraints:
                                      const BoxConstraints(minHeight: 100),
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 10, bottom: 10),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                              "开始时间: ${data['startKssj']}"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                "结束时间: ${data['endKssj']}")),
                                      ],
                                    ),
                                    Row(children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                              "氮分配比例(%): ${data['nfpbili']}")),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                              "氮养分(kg): ${data['nfpbili']}")),
                                    ]),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                "磷养分(kg): ${data['nfpbili']}")),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                "钾养分(kg): ${data['nfpbili']}")),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                "运行时间(分钟): ${data['runtime']}")),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                "灌溉量(吨): ${data['nfpbili']}")),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                "水分阈值(%): ${data['runtime']}")),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                "施肥浓度(‰): ${data['nfpbili']}")),
                                      ],
                                    ),
                                  ]),
                                )),
                          ],
                        ))));
          }).toList(),
        ));
  }
}

class YunxingguihuaChartsPage extends GetView {
  @override
  Widget build(BuildContext context) {
    YunxingguihuaController controller = Get.find<YunxingguihuaController>();
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: Column(
            children: [
              const Text(
                "各期养分用量",
                style: TextStyle(
                    leadingDistribution: TextLeadingDistribution.even,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    fontSize: 20),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: const Text("氮用量"),
                  ),
                  Container(
                    height: 15,
                    width: 30,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: const Text("磷用量"),
                  ),
                  Container(
                    height: 15,
                    width: 30,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: const Text("钾用量"),
                  ),
                  Container(
                    height: 15,
                    width: 30,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: Obx(() => BarChart(
                BarChartData(
                    alignment: BarChartAlignment.center,
                    maxY: 24,
                    groupsSpace: 20,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipPadding: const EdgeInsets.all(0),
                        tooltipBgColor: Colors.transparent,
                        tooltipMargin: 0,
                      ),
                    ),
                    barGroups: controller.table1Data,
                    titlesData: FlTitlesData(
                        topTitles: const AxisTitles(),
                        rightTitles: const AxisTitles(),
                        leftTitles: const AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                        )),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            var titleList = <String>["春梢", "夏梢", "秋梢", "冬梢"];
                            return SideTitleWidget(
                              space: 10,
                              axisSide: meta.axisSide,
                              child: Text(
                                titleList[value.toInt()],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            );
                          },
                        )))),
                swapAnimationDuration:
                    const Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear,
              )),
        ),
        Container(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: const Column(children: [
              Text(
                "各期灌溉量",
                style: TextStyle(
                    leadingDistribution: TextLeadingDistribution.even,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    fontSize: 20),
              ),
            ])),
        SizedBox(
          height: 200,
          child: Obx(() => BarChart(
                BarChartData(
                    alignment: BarChartAlignment.center,
                    maxY: 24,
                    groupsSpace: 20,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipPadding: const EdgeInsets.all(0),
                        tooltipBgColor: Colors.transparent,
                        tooltipMargin: 0,
                      ),
                    ),
                    barGroups: controller.table2Data,
                    titlesData: FlTitlesData(
                        topTitles: const AxisTitles(),
                        rightTitles: const AxisTitles(),
                        leftTitles: const AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                        )),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            var titleList = <String>["春梢", "夏梢", "秋梢", "冬梢"];
                            return SideTitleWidget(
                              space: 10,
                              axisSide: meta.axisSide,
                              child: Text(
                                titleList[value.toInt()],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            );
                          },
                        )))),
                swapAnimationDuration:
                    const Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear,
              )),
        ),
        Container(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: const Column(children: [
              Text(
                "各期水分阈值",
                style: TextStyle(
                    leadingDistribution: TextLeadingDistribution.even,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    fontSize: 20),
              ),
            ])),
        SizedBox(
          height: 200,
          child: Obx(() => BarChart(
                BarChartData(
                    alignment: BarChartAlignment.center,
                    maxY: 24,
                    groupsSpace: 20,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipPadding: const EdgeInsets.all(0),
                        tooltipBgColor: Colors.transparent,
                        tooltipMargin: 0,
                      ),
                    ),
                    barGroups: controller.table2Data,
                    titlesData: FlTitlesData(
                        topTitles: const AxisTitles(),
                        rightTitles: const AxisTitles(),
                        leftTitles: const AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                        )),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            var titleList = <String>["春梢", "夏梢", "秋梢", "冬梢"];
                            return SideTitleWidget(
                              space: 10,
                              axisSide: meta.axisSide,
                              child: Text(
                                titleList[value.toInt()],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            );
                          },
                        )))),
                swapAnimationDuration:
                    const Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear,
              )),
        ),
        Container(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: const Column(children: [
              Text(
                "各期施肥浓度",
                style: TextStyle(
                    leadingDistribution: TextLeadingDistribution.even,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    fontSize: 20),
              ),
            ])),
        SizedBox(
          height: 200,
          child: Obx(() => BarChart(
                BarChartData(
                    alignment: BarChartAlignment.center,
                    maxY: 24,
                    groupsSpace: 20,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipPadding: const EdgeInsets.all(0),
                        tooltipBgColor: Colors.transparent,
                        tooltipMargin: 0,
                      ),
                    ),
                    barGroups: controller.table2Data,
                    titlesData: FlTitlesData(
                        topTitles: const AxisTitles(),
                        rightTitles: const AxisTitles(),
                        leftTitles: const AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                        )),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            var titleList = <String>["春梢", "夏梢", "秋梢", "冬梢"];
                            return SideTitleWidget(
                              space: 10,
                              axisSide: meta.axisSide,
                              child: Text(
                                titleList[value.toInt()],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            );
                          },
                        )))),
                swapAnimationDuration:
                    const Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear,
              )),
        )
      ],
    );
  }
}
