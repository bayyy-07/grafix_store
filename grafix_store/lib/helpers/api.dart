import 'dart:convert';
import 'dart:io';  // Untuk menangani SocketException
import 'package:http/http.dart' as http;
import 'package:grafix_store/helpers/user_info.dart';
import 'package:grafix_store/helpers/api_url.dart';
import 'package:grafix_store/model/produk.dart';

import 'app_exception.dart';




class Api {
  // Fungsi untuk melakukan POST request
  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    var token = await UserInfo().getToken();
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(body), // Mengirim data dalam format JSON
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json", // Header untuk JSON
        },
      );
      return response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  // Fungsi untuk melakukan GET request
Future<http.Response> get(String url) async {
  var token = await UserInfo().getToken();
  try {
    final uri = Uri.parse(url);  // Mengonversi string URL menjadi Uri
    final response = await http.get(
      uri,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    print("Response Status: ${response.statusCode}");  // Cek status
    print("Response Body: ${response.body}");  //Cek data mentah dari API

    // Masih cek status code di sini biar bisa lempar error sesuai status
    _returnResponse(response);
    return response;  // Return http.Response asli buat di-handle di ProdukBloc
  } on SocketException {
    throw FetchDataException('No Internet connection');
  }
}

  // Fungsi untuk melakukan DELETE request
  Future<dynamic> delete(String url) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      final uri = Uri.parse(url);  // Mengonversi string URL menjadi Uri
      final response = await http.delete(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  // Menangani respons API
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return _parseResponse(response);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communicating with the server. StatusCode: ${response.statusCode}');
    }
  }

  // Memparsing response JSON
  dynamic _parseResponse(http.Response response) {
    try {
      return json.decode(response.body);  // Mengubah response menjadi objek JSON
    } catch (e) {
      throw FetchDataException('Error decoding response: ${e.toString()}');
    }
  }

  // Fungsi untuk melakukan PUT request
Future<http.Response> put(String url, Map<String, dynamic> body) async {
  var token = await UserInfo().getToken();
  try {
    final response = await http.put(
      Uri.parse(url),
      body: json.encode(body),  // Kirim data dalam format JSON
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",  // Header untuk JSON
      },
    );
    return response;
  } on SocketException {
    throw FetchDataException('No Internet connection');
  }
}
 


 // Fungsi untuk mengambil data profil pengguna
  static Future<Map<String, dynamic>?> UserProfile() async {
    final authKey = await UserInfo().getToken();
 // Ambil dari SharedPreferences
    final url = Uri.parse(ApiUrl.getProfile); // Gunakan konstanta dari ApiUrl

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $authKey', // Gunakan authKey yang sudah ada
        },
      );

      print("Response status: ${response.statusCode}");
      print("Response body: '${response.body}'");
      print("AuthKey: $authKey");


      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == true) {
          return result['data']; // Kembalikan data profil
        } else {
          throw Exception(result['message'] ?? 'Gagal memuat profil');
        }
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching profile: $e');
    }
  }

 Future<bool> createService({
  required String noSeri,
  required String perangkat,
  required String merekPerangkat,
  required String pelayanan,
  required String jenisKerusakan,
  required String detailKerusakan,
}) async {
  final url = Uri.parse(ApiUrl.postService);
  final token = await UserInfo().getToken();
  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'no_seri': noSeri,
      'perangkat': perangkat,
      'merek_perangkat': merekPerangkat,
      'pelayanan': pelayanan,
      'jenis_kerusakan': jenisKerusakan,
      'detail_kerusakan': detailKerusakan,
    }),
  );

  if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  return data['status'] == true; 
}

  print('DEBUG RESPONSE: ${response.statusCode}');
  print('DEBUG BODY: ${response.body}');
  return false;
}



  // fungsi untuk menerima data service
  Future<Map<String, dynamic>?> fetchService() async {
    try {
      final response = await get(ApiUrl.getService);
      return jsonDecode(response.body);
    } catch (e) {
      print("Error fetching service data: $e");
      return null;
    }
  }

  Future<Produk?> fetchProdukById(int id) async {
  final response = await http.get(Uri.parse('${ApiUrl.baseUrl}/produk/$id'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Produk.fromJson(data['data']);
  } else {
    return null;
  }
}


}
