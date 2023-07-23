import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceRepository {
  static SharePreferenceRepository? _instance;
  static SharedPreferences? _prefs;

  SharePreferenceRepository._internal();

  factory SharePreferenceRepository() => _instance!;

  static Future<SharePreferenceRepository> initInstance() async {
    if (_instance != null) return _instance!;
    _instance ??= SharePreferenceRepository._internal();
    _prefs = await SharedPreferences.getInstance();
    return _instance!;
  }

  loginSave(Map<String, dynamic> data) {
    _prefs!.setString('userId', data['user_id']);
    _prefs!.setString('accessToken', data['access_token']);
    _prefs!.setString('refreshToken', data['refresh_token']);
    _prefs!.setString('deptId', data['dept_id']);
    _prefs!.setString('roleId', data['role_id']);
  }

  isLogin() {
    return _prefs!.getString('accessToken') != null;
  }
}
