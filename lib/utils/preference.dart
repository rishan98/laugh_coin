
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
   static SharedPreferences? _preferences;

   static Future init () async =>
    _preferences = await SharedPreferences.getInstance();

   static Future setString(String? key,String value) async => await _preferences?.setString(key!, value);

   static Future reload() async => await _preferences?.reload();


   static remove(String? key) async => await _preferences?.remove(key!);



   static Future setInt(String key,int value) async => await _preferences?.setInt(key, value);

   static Future setBool(String key,bool value) async {
      await _preferences?.setBool(key, value);
   }

   static bool? getBool(String? key)  =>  _preferences?.getBool(key!);

   static String? getString(String key)  =>  _preferences?.getString(key);

   static int? getInt(String key)  =>  _preferences?.getInt(key);

   static clearPreferences() => _preferences?.clear();

   static reloadPreferences() => _preferences?.reload();
}