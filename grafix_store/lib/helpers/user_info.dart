import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  // Simpan token ke SharedPreferences dengan key 'auth_token'
  Future setToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString("auth_token", value);  
  }

  // Ambil token dari SharedPreferences dengan key 'auth_token'
  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("auth_token");  
  }

  // Simpan userID ke SharedPreferences
  Future setUserID(int value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setInt("userID", value);
  }

  // Ambil userID dari SharedPreferences
  Future<int?> getUserID() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("userID");
  }

  // Hapus semua data dari SharedPreferences (logout)
  Future logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }


  // Halaman Profile
  static Future<void> saveAuthKey(String authKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_key', authKey);
  }

  static Future<String?> getAuthKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_key');
  }

  static Future<void> clearAuthKey() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_key');
  }


}
