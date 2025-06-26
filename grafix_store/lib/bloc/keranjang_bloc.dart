import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grafix_store/helpers/api.dart';
import 'package:grafix_store/helpers/api_url.dart';
import 'package:grafix_store/helpers/user_info.dart';

class KeranjangBloc {
  // Fungsi untuk mengambil data keranjang berdasarkan user_id
  static Future getKeranjang() async {
    try {
      var response = await Api().get(ApiUrl.keranjang);
      print("Response Status: ${response.statusCode}"); // Untuk melihat status code
      print("Response Body: ${response.body}"); // Untuk melihat isi response

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to fetch keranjang: ${response.body}');
      }
    } catch (e) {
      print("Error fetching keranjang: $e"); // Log the error
      throw Exception('Error fetching keranjang: $e');
    }
  }

  // Fungsi untuk menambahkan item ke keranjang
  static Future tambah({
    int? produkId,
    int? jumlah,
    String? kategori,
    String? color,
    String? storage,
    String? namaProduk,
    String? hargaProduk,
  }) async {
    try {
      var userID = await UserInfo().getUserID();
      if (userID == null) {
        throw Exception("User ID tidak ditemukan");
      }

      
      print('UserID: $userID');
      print('Name: $namaProduk');
      print('harga_produk: $hargaProduk');
      print('ProdukID: $produkId');
      print('Jumlah: $jumlah');
      print('Kategori: $kategori');
      print('Color: $color');
      print('Storage: $storage');

     
      if (produkId == null || jumlah == null || kategori == null || color == null) {
        throw Exception('Missing required parameters');
      }

      var body = {
        'user_id': userID.toString(),
        'nama_produk': namaProduk.toString(),
        'harga_produk': hargaProduk.toString(),
        'produk_id': produkId.toString(),
        'jumlah': jumlah.toString(),
        'kategori': kategori,
        'color': color,
        'storage' : storage,
        
      };

      var response = await Api().post(ApiUrl.keranjang, body);

      print("Request Body: $body"); // Log request body
      print("Response Status: ${response.statusCode}"); // Log response status
      print("Response Body: ${response.body}"); // Log response body

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to add item to keranjang: ${response.body}');
      }
    } catch (e) {
      print("Error adding item to keranjang: $e"); 
      throw Exception('Error adding item to keranjang: $e');
    }
  }

  // Fungsi untuk menghapus item dari keranjang
  static Future deleteFromKeranjang(int itemId) async {
    try {
      var response = await Api().delete('${ApiUrl.keranjang}/hapus/$itemId');

      
      if (response != null && response.statusCode == 200) {
        print("Item deleted successfully");
        return response;
      } else {
        throw Exception('Failed to delete item from keranjang');
      }
    } catch (e) {
      print("Error deleting item from keranjang: $e"); 
      throw Exception('Error deleting item from keranjang: $e');
    }
  }

  // Fungsi Update jumlah dikeranjang
  static Future updateJumlah({required int keranjangId,required int jumlahBaru,}) async {
  try {
    var body = {
      'jumlah': jumlahBaru.toString(),
    };

    var response = await Api().post('${ApiUrl.keranjang}/updateJumlah/$keranjangId', body);

    print("Update jumlah response: ${response.statusCode} - ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal update jumlah');
    }
  } catch (e) {
    print("Error update jumlah: $e");
    throw Exception('Error update jumlah: $e');
  }
}






}
