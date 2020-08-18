import 'package:shared_preferences/shared_preferences.dart';

class Sharedpref {
  SharedPreferences sharedPrefs;
  Future getBoolSetting(String prefName) async {
    sharedPrefs = await SharedPreferences.getInstance();
    String tmpString = "";
    try {
      tmpString = sharedPrefs.getBool(prefName) ?? "";
      return tmpString;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getStringSetting(String prefName) async {
    sharedPrefs = await SharedPreferences.getInstance();
    String tmpString = "";
    try {
      tmpString = sharedPrefs.getString(prefName) ?? "";
      return tmpString;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getStringListSetting(String prefName) async {
    sharedPrefs = await SharedPreferences.getInstance();
    List<String> tmpString = [];
    try {
      tmpString = sharedPrefs.getStringList(prefName) ?? [];
      return tmpString;
    } catch (e) {
      return null;
    }
  }

  Future<void> prepareBoolSetting(String prefName, bool initVal) async {
    sharedPrefs = await SharedPreferences.getInstance();
    try {
      sharedPrefs.getString(prefName) ?? await sharedPrefs.setBool(prefName, initVal);
    } catch (e) {
      print(e);
    }
  }

  Future<void> prepareStringSetting(String prefName, String initVal) async {
    sharedPrefs = await SharedPreferences.getInstance();
    try {
      sharedPrefs.getString(prefName) ?? await sharedPrefs.setString(prefName, initVal);
    } catch (e) {
      print(e);
    }
  }

  Future<void> prepareStringListSetting(String prefName, List<String> initVal) async {
    sharedPrefs = await SharedPreferences.getInstance();
    try {
      sharedPrefs.getStringList(prefName) ?? await sharedPrefs.setStringList(prefName, initVal);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateBoolSetting(String prefName, bool initVal) async {
    sharedPrefs = await SharedPreferences.getInstance();
    try {
      await sharedPrefs.setBool(prefName, initVal);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateStringSetting(String prefName, String initVal) async {
    sharedPrefs = await SharedPreferences.getInstance();
    try {
      await sharedPrefs.setString(prefName, initVal);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateStringListSetting(String prefName, List<String> initVal) async {
    sharedPrefs = await SharedPreferences.getInstance();
    try {
      await sharedPrefs.setStringList(prefName, initVal);
    } catch (e) {
      print(e);
    }
  }
}
