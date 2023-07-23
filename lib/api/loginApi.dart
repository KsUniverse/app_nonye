import 'dart:convert';

import 'package:app_nongye/network/dio_client.dart';
import 'package:crypto/crypto.dart';

Future<Map<String, dynamic>> loginApi(String username, String password) async {
  return await DioClient()
      .request("/blade-auth/oauth/token", method: "POST", params: {
    "tenantId": "000000",
    "username": username,
    "password": md5.convert(utf8.encode(password)).toString(),
    "grant_type": "password",
    "scope": "all",
    "type": "account"
  });
}
