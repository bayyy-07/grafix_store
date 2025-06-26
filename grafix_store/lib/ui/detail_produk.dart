import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:grafix_store/model/produk.dart';
import 'package:grafix_store/helpers/user_info.dart';
import 'package:grafix_store/ui/compare_selection_page.dart';
import 'package:http/http.dart' as http;

class DetailProdukPage extends StatefulWidget {
  final Produk produk;

  const DetailProdukPage({super.key, required this.produk});

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  String selectedStorage = '256GB/8GB';
  String selectedColor = 'Blue';

  final List<String> storages = ['128GB/6GB', '256GB/8GB', '512GB/12GB'];
  final List<String> colors = ['Blue', 'Black', 'White'];

  String formatRupiah(int harga) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatCurrency.format(harga);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('images/logo.png', height: 120),
        actions: [
          IconButton(
            icon: const Icon(Icons.support_agent, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Atur ke min
          children: [
            // Gambar Produk
            Center(
              child: Image.asset(
                'images/${widget.produk.image}',
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Harga & Nama Produk
            Text(
              formatRupiah(widget.produk.hargaProduk ?? 0),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.produk.namaProduk ?? 'Nama Produk',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),

            // Stok & Info
            const SizedBox(height: 4),
            const Text(
              'Stok Terbatas',
              style: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
            ),

            // Badge & Rating
            const SizedBox(height: 8),
            Row(
              children: [
                _buildOngkirBadge('Bebas Ongkir', Colors.red),
                const SizedBox(width: 3),
                _buildCicilanBadge('Cicilan 0% 24 Bulan', Colors.orange),
                const SizedBox(width: 3),
                
              ],
            ),
            Row(
              children: [
                _buildRatingBadge('5.0'),
              ],
            ),

            const SizedBox(height: 16),

            // Pilihan Varian
            _buildDropdown('Storage:', storages, selectedStorage, (value) {
              setState(() {
                selectedStorage = value;
              });
            }),

            // Pilihan Color
            _buildDropdown('Color:', colors, selectedColor, (value) {
              setState(() {
                selectedColor = value;
              });
            }),

            const SizedBox(height: 16),

            // Deskripsi Produk
            const Text(
              'Deskripsi Produk',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildProductDescription(),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // Tombol Beli & Keranjang
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompareSelectionPage(produk1: widget.produk),

                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Bandingkan', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  tambah();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('+ Keranjang', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Badge
  Widget _buildOngkirBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset('images/free-shipping.png', height: 20),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(color: Colors.orange)),
        ],
      ),
    );
  }

  Widget _buildCicilanBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset('images/wallet.png', height: 18),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(color: const Color.fromARGB(255, 252, 3, 3))),
        ],
      ),
    );
  }

  // Widget Badge Rating
  Widget _buildRatingBadge(String rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 237, 214, 4).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.yellow, size: 20),
          const SizedBox(width: 4),
          Text('$rating/5', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Widget Dropdown Pilihan Storage & Color
  Widget _buildDropdown(String label, List<String> items, String selectedItem, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(selectedItem) ? selectedItem : items.first,
              onChanged: (value) {
                if (value != null) {
                  onChanged(value);
                }
              },
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // Widget Deskripsi Produk
  Widget _buildProductDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('• Ukuran Layar: 6.7 inch, Dynamic AMOLED 2X'),
        Text('• Layar Luar: 3.4 inch, Super AMOLED'),
        Text('• Kapasitas RAM 12 GB, ROM 256 GB'),
        Text('• CPU: Qualcomm Snapdragon 8 Gen 2'),
      ],
    );
  }

  Future<void> tambah() async {
    final token = await UserInfo().getToken();  // Ambil token dari SharedPreferences
    final userId = await UserInfo().getUserID();  // Ambil userID dari SharedPreferences

    // Log untuk memeriksa apakah user_id dan token ada
    print('User  ID: $userId');
    print('Token: $token');  // Ganti auth_key dengan token yang didapatkan

    // Jika user_id atau token tidak ditemukan, tampilkan pesan bahwa user belum login
    if (userId == null || token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anda belum login.')),
      );
      return;  
    }

    // Jika user sudah login, lanjutkan untuk mengirim permintaan ke API untuk menambah produk ke keranjang
    final response = await http.post(
      Uri.parse('http://192.168.96.114/grafix_API/public/api/keranjang/tambah'),
      headers: {
        'Authorization': 'Bearer $token',  // Menambahkan header token
      },
      body: {
        'user_id': userId.toString(),
        'produk_id': widget.produk.id.toString(),
        'jumlah': '1',
        'name': widget.produk.namaProduk.toString(),
        'price': widget.produk.hargaProduk.toString(),
        'image': widget.produk.image ?? 'default_image.jpg',
        'storage': selectedStorage,
        'color': selectedColor,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Berhasil ditambahkan ke keranjang.')),
      );
    } else {
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan ke keranjang: ${response.body}')),
      );
    }
  }
}