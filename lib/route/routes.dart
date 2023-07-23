import 'package:app_nongye/database/login_data.dart';
import 'package:app_nongye/page/Home.dart';
import 'package:app_nongye/page/login.dart';

import '../page/params/zhongzhi_jihua_detail.dart';

var routes = {
  "/": (context) {
    return SharePreferenceRepository().isLogin()
        ? HomePage()
        : const LoginPage();
  },
  "/login": (context) => const LoginPage(),
  "/home": (context) => HomePage(),
  "/zhongzhijihua_detial": (context) {
    return const ZhongzhiJihuaDetailPage();
  }
};
