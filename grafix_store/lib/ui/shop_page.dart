import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:grafix_store/bloc/produk_bloc.dart';
import 'package:grafix_store/model/produk.dart';
import 'package:intl/intl.dart';
import 'package:grafix_store/ui/detail_produk.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String selectedKategori = 'Semua';
  String selectedSort = 'Urutkan';
  String selectedBrand = 'Brand';
  String selectedRating = 'Rating';
  bool showBrandSuggestions = false;

  final List<String> kategori = ['Semua', 'Handphone', 'Laptop', 'Television'];
  final List<String> sortOptions = ['Urutkan', 'Harga Terendah', 'Harga Tertinggi'];
  final List<String> brands = ['Brand', 'Samsung', 'Apple', 'Xiaomi', 'Huawei', 'LG'];
  final List<String> ratings = ['Rating', '4 ke atas', '3 ke atas', '2 ke atas'];

  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _searchController,
                onTap: () {
                  setState(() {
                    showBrandSuggestions = true;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                    if (value.isEmpty) {
                      showBrandSuggestions = false;
                    }
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Cari produk...',
                  hintStyle: const TextStyle(color: Colors.black, fontSize: 18),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        showBrandSuggestions = true;
                      });
                    },
                  ),
                ),
              ),
            ),

            // Brand suggestions
            if (showBrandSuggestions)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 9.0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    'Samsung', 'Tecno', 'Apple', 'Xiaomi', 'Vivo', 'LG', 'Huawei', 'Huawei Matebook'
                  ].map((brand) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _searchController.text = brand;
                          searchQuery = brand.toLowerCase();
                          showBrandSuggestions = false;
                        });
                      },
                      child: Chip(
                        label: Text(brand),
                        backgroundColor: Colors.white,
                        shape: const StadiumBorder(side: BorderSide(color: Colors.black)),
                      ),
                    );
                  }).toList(),
                ),
              ),

            // Filter Options
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildDropdown('Semua', kategori, selectedKategori, (value) {
                    setState(() {
                      selectedKategori = value;
                    });
                  }),
                  const SizedBox(width: 8),
                  _buildDropdown('Urutkan', sortOptions, selectedSort, (value) {
                    setState(() {
                      selectedSort = value;
                    });
                  }),
                  const SizedBox(width: 8),
                  _buildDropdown('Brand', brands, selectedBrand, (value) {
                    setState(() {
                      selectedBrand = value;
                    });
                  }),
                  const SizedBox(width: 8),
                  _buildDropdown('Rating', ratings, selectedRating, (value) {
                    setState(() {
                      selectedRating = value;
                    });
                  }),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Produk Grid Responsif
            Expanded(
              child: FutureBuilder<List<Produk>>(
                future: ProdukBloc.getProduks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Tidak ada produk tersedia.'));
                  } else {
                    var produkList = List.from(snapshot.data!);

                    // Filter dan sort
                    if (selectedKategori != 'Semua' && selectedKategori.isNotEmpty) {
                      produkList = produkList.where((p) => p.kategori == selectedKategori).toList();
                    }
                    if (selectedBrand != 'Brand') {
                      produkList = produkList.where((p) => p.brand == selectedBrand).toList();
                    }
                    if (selectedSort == 'Harga Terendah') {
                      produkList.sort((a, b) => (a.hargaProduk ?? 0).compareTo(b.hargaProduk ?? 0));
                    } else if (selectedSort == 'Harga Tertinggi') {
                      produkList.sort((a, b) => (b.hargaProduk ?? 0).compareTo(a.hargaProduk ?? 0));
                    }
                    if (searchQuery.isNotEmpty) {
                      produkList = produkList.where((p) =>
                        p.namaProduk != null &&
                        p.namaProduk!.toLowerCase().contains(searchQuery)
                      ).toList();
                    }

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = 2;
                        if (constraints.maxWidth > 600) crossAxisCount = 3;
                        if (constraints.maxWidth > 900) crossAxisCount = 4;

                        return GridView.builder(
                          padding: const EdgeInsets.only(bottom: 13),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: 0.6,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: produkList.length,
                          itemBuilder: (context, index) {
                            final produk = produkList[index];
                            return _buildProductCard(produk);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Dropdown
  Widget _buildDropdown(String label, List<String> items, String selectedItem, Function(String) onChanged) {
    return Container(
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
    );
  }

  // Kartu Produk
  Widget _buildProductCard(Produk produk) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProdukPage(produk: produk),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.asset(
                  'images/${produk.image}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produk.namaProduk ?? 'Nama Produk',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatRupiah(produk.hargaProduk ?? 0),
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text('${produk.rating ?? 0}/5'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
