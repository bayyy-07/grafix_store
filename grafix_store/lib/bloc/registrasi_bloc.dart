import 'dart:convert';
import 'package:grafix_store/helpers/api.dart';
import 'package:grafix_store/helpers/api_url.dart';
import 'package:grafix_store/model/registrasi.dart';
import 'package:grafix_store/helpers/app_exception.dart';  

class RegistrasiBloc {
  static Future<Registrasi> registrasi(
      {String? nama, String? email, String? password}) async {
    String apiUrl = ApiUrl.registrasi;

    var body = {
      "nama": nama,
      "email": email,
      "password": password
    };

    try {
      var response = await Api().post(apiUrl, body);

      // Memastikan response statusnya OK (200)
      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);
        return Registrasi.fromJson(jsonObj);
      } else {
        // Jika server mengembalikan status selain 200
        throw FetchDataException('Failed to register. Please try again.');
      }
    } catch (e) {
      // Menangani error, baik itu error koneksi atau server
      throw FetchDataException('Error occurred during registration: $e');
    }
  }
}
