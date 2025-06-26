import 'package:shared_preferences/shared_preferences.dart';

class LogoutBloc {
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); 
    await prefs.remove('user_id'); 
  }
}
