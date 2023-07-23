import 'package:app_nongye/api/business.dart';
import 'package:get/get.dart';

class ZhongzhiJihuaController extends GetxController {
  RxList<Map<String, dynamic>> datas = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    datas.clear();
    zhongzhijihuaList().then((value) {
      value['data'].forEach((element) {
        datas.add(element);
      });
    });
  }
}
