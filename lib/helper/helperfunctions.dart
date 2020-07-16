import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

  //saving data to SharedPreference

  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    return await prefs.setString(sharedPreferenceUserEmailKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  // Getting data from SharedPreferences

  static Future<bool> getUserLoggedInSharedPreference() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    return await prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getUserNameSharedPreference() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    return await prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailSharedPreference() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    return await prefs.getString(sharedPreferenceUserEmailKey);
  }
}
