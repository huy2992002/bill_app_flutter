import '../services/local/shared_preferences_helper.dart';

class Authen {
  static String? username = '';
  static String? password = '';
  static bool? isLogin = false;

  static Future<void> saveData() async {
    await SharedPreferencesHelper.saveAuthenData(username!, password!, isLogin!);
  }

  static Future<void> loadData() async {
    await SharedPreferencesHelper.loadAuthenData();
  }
}

