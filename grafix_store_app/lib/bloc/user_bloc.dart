// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:grafix_store/helpers/api.dart';
// import 'package:grafix_store/helpers/api_url.dart';
// import 'package:grafix_store/helpers/user_info.dart';

// class UserBloc {
//   // Fungsi untuk mengambil data user berdasarkan user_id
//   static Future UserProfile() async {
//     try {
//       var response = await Api().get(ApiUrl.keranjang);
//       print("Response Status: ${response.statusCode}"); // Untuk melihat status code
//       print("Response Body: ${response.body}"); // Untuk melihat isi response

//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         return jsonResponse;
//       } else {
//         throw Exception('Failed to fetch keranjang: ${response.body}');
//       }
//     } catch (e) {
//       print("Error fetching keranjang: $e"); // Log the error
//       throw Exception('Error fetching keranjang: $e');
//     }
//   }



// }