import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencesServices {




  static Future<bool> addBool({required String key, required bool value}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool result = await preferences.setBool(key, value);
    return result;
  }

  static Future<bool> getBool({required String key}) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool result =  preferences.getBool(key) ?? false;
    return result;
  }

  static Future<bool> changeBoolValue(
      {required String key, required bool value}) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
    bool result = await addBool(key: key, value: value);
    return result;
  }

  static Future<bool> checkKey({required String key}) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool result = preferences.containsKey(key);
    return result;
  }
}
