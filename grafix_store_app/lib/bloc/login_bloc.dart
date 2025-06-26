import 'dart:convert';
import 'package:grafix_store/helpers/api.dart';
import 'package:grafix_store/helpers/api_url.dart';
import 'package:grafix_store/model/login.dart';
import 'package:grafix_store/model/loginResponse.dart';
import 'package:grafix_store/helpers/user_info.dart';



class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"email": email, "password": password};

    try {
      var response = await Api().post(apiUrl, body);

      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);
        var loginData = Login.fromJson(jsonObj);

        // Mengecek apakah token valid
        if (loginData.token != null && loginData.token!.isNotEmpty) {
          // Simpan token ke SharedPreferences
          print("Token dari API: ${loginData.token}");

          await UserInfo().setToken(loginData.token!);  

          // Debug Pastikan token benar-benar tersimpan
          final storedToken = await UserInfo().getToken();
          print("Token yang tersimpan di SharedPreferences: $storedToken");


          // Mengecek apakah token ada setelah disimpan
          if (storedToken != null && storedToken.isNotEmpty) {
            print("Token berhasil disimpan!");
          } else {
            print("Token tidak berhasil disimpan!");
          }

        } else {
          throw Exception('Token is missing or empty');
        }

        return loginData;
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }
}
