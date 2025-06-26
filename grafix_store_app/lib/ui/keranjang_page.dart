import 'package:flutter/material.dart';
import 'package:grafix_store/model/keranjang.dart';
import 'package:grafix_store/helpers/api.dart';
import 'package:grafix_store/helpers/api_url.dart';

import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'midtrans_payment_page.dart';


class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  List<Keranjang> keranjangList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchKeranjang();
  }

  Future<void> fetchKeranjang() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    print("Token di fetchKeranjang: $token");

    if (token == null) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            title: Text("Akses Ditolak"),
            content: Text("Token tidak ditemukan. Silakan login terlebih dahulu."),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('http://192.168.96.114/grafix_API/public/api/keranjang'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Data dari backend: $data");

        setState(() {
          keranjangList = List<Keranjang>.from(data.map((item) => Keranjang.fromJson(item)));
          isLoading = false;
        });
      } else {
        throw Exception('Gagal memuat keranjang: ${response.body}');
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  String formatRupiah(int harga) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatCurrency.format(harga);
  }

  int totalHarga() {
    return keranjangList.fold(0, (sum, item) {
      return sum + (item.hargaProduk ?? 0) * (item.jumlah ?? 1);
    });
  }


  // Class Hapus Keranjang
  void confirmHapus(Keranjang item) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Konfirmasi"),
          content: const Text("Yakin ingin menghapus item ini dari keranjang?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                hapusItemKeranjang(item);
              },
              child: const Text("Hapus"),
            ),
          ],
        ),
      );
    }

      Future<void> hapusItemKeranjang(Keranjang item) async {
  try {
    final response = await Api().delete('http://192.168.96.114/grafix_API/public/api/hapus/${item.id}');

    if (response['status'] == true) {
      setState(() {
        keranjangList.removeWhere((e) => e.id == item.id);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus item: ${response['message'] ?? 'Unknown error'}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}


  // Fungsi Update Jumlah item Dikeranjangggg
Future<void> updateJumlahItem(Keranjang item, int newJumlah) async {
  if (newJumlah < 1) return;

  try {
    final response = await http.post(
      Uri.parse('http://192.168.96.114/grafix_API/public/api/keranjang/updateJumlah/${item.id}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'jumlah': newJumlah,
      }),
    );

    final data = json.decode(response.body);
    if (response.statusCode == 200 && data['status'] == true) {
      setState(() {
        item.jumlah = newJumlah;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal update jumlah: ${data['message']}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

Future<void> mulaiPembayaran() async {
  print("MULAI PEMBAYARAN"); 
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');

  if (token == null) {
    print("Token tidak ditemukan");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Token tidak ditemukan. Silakan login ulang.")),
    );
    return;
  }

  try {
    final response = await http.post(
      Uri.parse('http://192.168.96.114/grafix_API/public/payment/token'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'user_id': await getUserIdFromToken(token)}),
    );
    print("Status code: ${response.statusCode}");
    print("Response body dari token: ${response.body}");

    if (response.statusCode == 200) {
      
      final data = jsonDecode(response.body);
      print("Response body dari token: ${response.body}");
      print("Tipe data: ${data.runtimeType}");

      final snapToken = data['token']; // ✅ benar karena backend kirim object


      final hasil = await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MidtransPaymentPage(snapToken: snapToken)),
      );

      if (hasil == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pembayaran berhasil!")),
        );
        fetchKeranjang(); // reload keranjang
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pembayaran dibatalkan.")),
        );
      }
    } else {
      throw Exception('Gagal mendapatkan token pembayaran: ${response.body}');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error pembayaran: $e')),
    );
  }
  
}

// DUMMY fungsi untuk mendapatkan user_id dari token
Future<String> getUserIdFromToken(String? token) async {
  print("getUserIdFromToken called with token: $token");

  try {
    final response = await http.get(
      Uri.parse('http://192.168.96.114/grafix_API/public/api/user'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print("Response user: ${response.statusCode} ${response.body}");

    if (response.statusCode != 200) {
      print("Gagal mendapatkan user. Status: ${response.statusCode}");
      throw Exception("Gagal mendapatkan user");
    }

    final data = jsonDecode(response.body);
    print("Data user: $data");

    return data['id'].toString();
  } catch (e) {
    print("Error di getUserIdFromToken: $e");
    rethrow;
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset('images/logo.png', height: 120),
            const Spacer(),
            IconButton(
            icon: const Icon(Icons.support_agent, color: Colors.black, size: 30),
            onPressed: () {},
          ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : keranjangList.isEmpty
              ? const Center(child: Text('Keranjang kosong'))
              : ListView.builder(
                  itemCount: keranjangList.length,
                  itemBuilder: (context, index) {
                    final item = keranjangList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: item.image != null && item.image!.isNotEmpty
                                ? Image.asset(
                                    'images/${item.image}',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.image_not_supported, size: 80),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.namaProduk ?? '-', style: const TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text('Storage: ${item.storage ??'-'}', style: const TextStyle(color: Colors.grey)),
                                const SizedBox(height: 4),


                                Text(formatRupiah(item.hargaProduk ?? 0),
                                    style: const TextStyle(color: Colors.grey)),
                                const SizedBox(height: 8),
                               
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if ((item.jumlah ?? 1) > 1) {
                                        updateJumlahItem(item, (item.jumlah ?? 1) - 1);
                                      }
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Text('${item.jumlah ?? 1}'),
                                  IconButton(
                                    onPressed: () {
                                      updateJumlahItem(item, (item.jumlah ?? 1) + 1);
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),

                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => confirmHapus(item),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(formatRupiah(totalHarga()), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  mulaiPembayaran();
                },
                child: const Text("Lanjut ke pembayaran", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {},
                child: const Text("Lanjut berbelanja"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
