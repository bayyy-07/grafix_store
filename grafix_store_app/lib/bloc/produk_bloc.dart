import 'dart:convert';
import 'package:grafix_store/helpers/api.dart';
import 'package:grafix_store/helpers/api_url.dart';
import 'package:grafix_store/model/produk.dart';
import 'package:grafix_store/helpers/app_exception.dart';

class ProdukBloc {
  // Fungsi untuk mengambil list produk
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;
    try {
      var response = await Api().get(apiUrl);

      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);
        List<dynamic> listProduk = jsonObj['data'];
        
        return listProduk.map((produk) => Produk.fromJson(produk)).toList();
      } else {
        throw FetchDataException('Failed to load products. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw FetchDataException('Error occurred while fetching products: $e');
    }
  }

  // Fungsi untuk menambah produk
  static Future<String> addProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.createProduk;

    var body = {
      "nama_produk": produk.namaProduk,
      "image_produk": produk.image,  
      "brand_produk": produk.brand,
      "rating_produk": produk.rating,  
      "harga": produk.hargaProduk.toString(),
    };

    try {
      var response = await Api().post(apiUrl, body);
      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);
        return jsonObj['status'] ?? 'No status found';
      } else {
        throw FetchDataException('Failed to add product. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw FetchDataException('Error occurred while adding product: $e');
    }
  }

  // Fungsi untuk memperbarui produk
  static Future<bool> updateProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.updateProduk(produk.id!);

    var body = {
      "nama_produk": produk.namaProduk,
      "image_produk": produk.image,  
      "brand_produk": produk.brand, 
      "kategori_produk": produk.kategori, 
      "rating_produk": produk.rating,  
      "harga": produk.hargaProduk.toString(),
    };

    try {
      // PUT request
      var response = await Api().put(apiUrl, body);
      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);
        return jsonObj['data'] ?? false;
      } else {
        throw FetchDataException('Failed to update product. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw FetchDataException('Error occurred while updating product: $e');
    }
  }

  // Fungsi untuk menghapus produk
  static Future<bool> deleteProduk({required int id}) async {
    String apiUrl = ApiUrl.deleteProduk(id);

    try {
      var response = await Api().delete(apiUrl);
      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);
        return jsonObj['data'] ?? false;
      } else {
        throw FetchDataException('Failed to delete product. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw FetchDataException('Error occurred while deleting product: $e');
    }
  }
}
