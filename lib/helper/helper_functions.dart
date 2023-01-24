import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //Keys
  static String userLoggedInKey = 'LOGGEDINKEY';
  static String userNamekey = 'USERNAMEKEY';
  static String userEmailKey = 'EMAILKEY';

  //getting data from SF
  static Future<bool?> userLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }
}
