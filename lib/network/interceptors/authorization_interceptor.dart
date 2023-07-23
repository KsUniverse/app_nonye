import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const String API_KEY = 'c2FiZXI6c2FiZXJfc2VjcmV0';

//* Request methods PUT, POST, PATCH, DELETE needs access token,
//* which needs to be passed with "Authorization" header as Bearer token.
class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Authorization'] = "Basic $API_KEY";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("accessToken") != null) {
      options.headers['Blade-Auth'] =
          'Bearer ${prefs.getString("accessToken")}';
    }
    super.onRequest(options, handler);
  }
}
