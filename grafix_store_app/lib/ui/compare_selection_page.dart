import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:grafix_store/model/produk.dart';
import 'package:grafix_store/helpers/api.dart';
import 'package:grafix_store/helpers/api_url.dart';
import 'compare_page.dart';

class CompareSelectionPage extends StatefulWidget {
  final Produk produk1;

  CompareSelectionPage({required this.produk1});

  @override
  State<CompareSelectionPage> createState() => _CompareSelectionPageState();
}

class _CompareSelectionPageState extends State<CompareSelectionPage> {
  List<Produk> produkList = [];
  bool isLoading = true;
  String? errorMessage;

  String selectedKategori = 'Semua';
  String selectedSort = 'Urutkan';
  String selectedBrand = 'Brand';
  String selectedRating = 'Rating';
  bool showBrandSuggestions = false;

  final List<String> kategori = ['Semua', 'Handphone', 'Laptop', 'Television'];
  final List<String> sortOptions = ['Urutkan', 'Harga Terendah', 'Harga Tertinggi'];
  final List<String> brands = ['Brand', 'Samsung', 'Apple', 'Xiaomi', 'Huawei', 'LG'];
  final List<String> ratings = ['Rating', '4 ke atas', '3 ke atas', '2 ke atas'];

  final List<String> brandSuggestions = [
    'Samsung', 'Tecno', 'Apple', 'Xiaomi', 'Vivo', 'LG', 'Huawei', 'Huawei Matebook'
  ];

  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchProdukList();
  }

  void fetchProdukList() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await Api().get(ApiUrl.listProduk);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['data'] != null) {
          List<dynamic> produkJsonList = jsonData['data'];
          List<Produk> loadedProduk = produkJsonList.map((item) => Produk.fromJson(item)).toList();
          setState(() {
            produkList = loadedProduk;
          });
        } else {
          setState(() {
            errorMessage = "Data produk tidak ditemukan";
          });
        }
      } else {
        setState(() {
          errorMessage = "Gagal mengambil produk, status: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error saat fetch produk: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatRupiah(int harga) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatCurrency.format(harga);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Pilih Produk Pembanding")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: Text("Pilih Produk Pembanding")),
        body: Center(child: Text(errorMessage!)),
      );
    }

    var filteredProdukList = List<Produk>.from(produkList);

    if (selectedKategori != 'Semua') {
      filteredProdukList = filteredProdukList.where((p) => p.kategori == selectedKategori).toList();
    }

    if (selectedBrand != 'Brand') {
      filteredProdukList = filteredProdukList.where((p) => p.brand == selectedBrand).toList();
    }

    if (selectedSort == 'Harga Terendah') {
      filteredProdukList.sort((a, b) => (a.hargaProduk ?? 0).compareTo(b.hargaProduk ?? 0));
    } else if (selectedSort == 'Harga Tertinggi') {
      filteredProdukList.sort((a, b) => (b.hargaProduk ?? 0).compareTo(a.hargaProduk ?? 0));
    }

    if (searchQuery.isNotEmpty) {
      filteredProdukList = filteredProdukList
          .where((p) => p.namaProduk != null && p.namaProduk!.toLowerCase().contains(searchQuery))
          .toList();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset('images/logo.png', height: 40),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.support_agent, color: Colors.black, size: 30),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(children: [
                Text("Pilih produk yang ingin dibandingkan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
              ],),
              // Search Bar
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _searchController,
                  onTap: () => setState(() => showBrandSuggestions = true),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                      if (value.isEmpty) showBrandSuggestions = false;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Cari produk...',
                    hintStyle: const TextStyle(color: Colors.black, fontSize: 18),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search, color: Colors.grey),
                      onPressed: () => setState(() => showBrandSuggestions = true),
                    ),
                  ),
                ),
              ),

              // Brand Chips
              if (showBrandSuggestions)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: brandSuggestions.map((brand) {
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
                          shape: StadiumBorder(side: BorderSide(color: Colors.black)),
                        ),
                      );
                    }).toList(),
                  ),
                ),

              // Filter Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildDropdown('Semua', kategori, selectedKategori, (val) => setState(() => selectedKategori = val)),
                    const SizedBox(width: 8),
                    _buildDropdown('Urutkan', sortOptions, selectedSort, (val) => setState(() => selectedSort = val)),
                    const SizedBox(width: 8),
                    _buildDropdown('Brand', brands, selectedBrand, (val) => setState(() => selectedBrand = val)),
                    const SizedBox(width: 8),
                    _buildDropdown('Rating', ratings, selectedRating, (val) => setState(() => selectedRating = val)),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Grid Produk
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 2;
                    if (constraints.maxWidth >= 900) crossAxisCount = 4;
                    else if (constraints.maxWidth >= 600) crossAxisCount = 3;

                    return GridView.builder(
                      padding: const EdgeInsets.only(bottom: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: filteredProdukList.length,
                      itemBuilder: (context, index) {
                        final produk = filteredProdukList[index];
                        return _buildProductCard(produk);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
          onChanged: (value) => value != null ? onChanged(value) : null,
          items: items.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildProductCard(Produk produk) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => CompareResultPage(
            produk1: widget.produk1,
            produk2Id: produk.id!,
          ),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 4, spreadRadius: 1)],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'images/${produk.image}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              produk.namaProduk ?? 'Nama Produk',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              formatRupiah(produk.hargaProduk ?? 0),
              style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold),
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
    );
  }
}
