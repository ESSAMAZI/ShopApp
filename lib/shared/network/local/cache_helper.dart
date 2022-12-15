import 'package:shared_preferences/shared_preferences.dart';

//حفظ اعدادات الثيم عند فتح التطبيق كل مره
class CacheHelper {
  static late SharedPreferences sharedpreferences;
  static init() async {
    sharedpreferences = await SharedPreferences.getInstance();
  }

  //set data
  static Future<bool> putData(
      {required String key, required bool value}) async {
    return await sharedpreferences.setBool(key, value);
  }

  //get data
  //جلب البيانات
  static dynamic getData({required String key}) {
    return sharedpreferences.get(key);
  }

  static Future<bool> saveDatas(
      {required String key, required var value}) async {
    //
    if (value is String) return await sharedpreferences.setString(key, value);
    if (value is int) return await sharedpreferences.setInt(key, value);
    if (value is bool) return await sharedpreferences.setBool(key, value);

    return await sharedpreferences.setDouble(key, value);
  }

  static Future<bool> clearData({required String key}) async {
    return await sharedpreferences.remove(key);
  }
}
