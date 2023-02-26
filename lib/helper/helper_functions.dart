import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //Keys
  static String userLoggedInKey = 'LOGGEDINKEY';
  static String userNamekey = 'USERNAMEKEY';
  static String userEmailKey = 'EMAILKEY';

// saving data to SF
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNamekey, userName);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  //getting data from SF
  static Future<bool?> userLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

   static Future<String?> getUserEmailfromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
  return sf.getString(userEmailKey);
  }
 static Future<String?> getUserNamefromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNamekey);
  }
}
