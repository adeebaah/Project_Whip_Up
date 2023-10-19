import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';
  static const String userNameKey = 'user_name';

  Future<void> storeUserData(
      String userId, String userEmail, String userName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userIdKey, userId);
    prefs.setString(userEmailKey, userEmail);
    prefs.setString(userNameKey, userName);
  }

  Future<Map<String, String>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(userIdKey);
    String? userEmail = prefs.getString(userEmailKey);
    String? userName = prefs.getString(userNameKey);

    return {
      'user_id': userId ?? '',
      'user_email': userEmail ?? '',
      'user_name': userName ?? '',
    };
  }
}
