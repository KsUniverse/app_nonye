import 'package:app_nongye/network/dio_client.dart';

zhongzhijihuaList() async {
  return await DioClient().request("/blade-zhongzhibiao/zhongzhibiao/list");
}

zhongzhijihuaUpdate(data) async {
  return await DioClient().request("/blade-zhongzhibiao/zhongzhibiao/update",
      method: 'post', data: data);
}

nongzuowuList() async {
  return await DioClient().request("/blade-nongzuowu/nongzuowu/list");
}

nongzuowuUpdate(data) async {
  return await DioClient()
      .request("/blade-nongzuowu/nongzuowu/submit", method: 'post', data: data);
}

yunxingguanliList() async {
  return await DioClient().request("/blade-runManager/runManager/list");
}

yunxingguanliUpdate(data) async {
  return await DioClient().request("/blade-runManager/runManager/update",
      method: 'post', data: data);
}

yunxingguihuaList() async {
  return await DioClient().request("/blade-runManager/runManager/listByzzdy");
}

systemProperitesList() async {
  return await DioClient()
      .request("blade-systemProperties/systemProperties/list");
}

systemProperitesUpdate(data) async {
  return await DioClient().request(
      "blade-systemProperties/systemProperties/updateList",
      method: 'post',
      data: data);
}

zidongyunxingList() async {
  return await DioClient()
      .request("blade-autoRunSettings/autoRunSettings/list");
}
