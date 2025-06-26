import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grafix_store/ui/shop_page.dart';
import 'package:grafix_store/ui/detail_produk.dart';
import 'package:grafix_store/ui/penawaran_page.dart';
import 'package:grafix_store/ui/keranjang_page.dart';
import 'package:grafix_store/ui/profile_page.dart';
import 'package:grafix_store/ui/login_page.dart';
import 'package:grafix_store/bloc/produk_bloc.dart';
import 'package:grafix_store/model/produk.dart';
import 'package:intl/intl.dart';
import 'package:grafix_store/helpers/user_info.dart';
import 'package:grafix_store/helpers/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContentPage(),
    const ShopPage(),
    const PenawaranPage(),
    const KeranjangPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: UserInfo().getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          return const LoginPage();
        } else {
          return Scaffold(
            body: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                setState(() => _currentIndex = index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
                BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Shop'),
                BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Penawaran'),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Keranjang'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
              ],
            ),
          );
        }
      },
    );
  }
}

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });

    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final data = await Api.UserProfile();
      setState(() {
        userData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint("Error fetching profile: $e");
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  String formatRupiah(int? harga) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatCurrency.format(harga ?? 0);
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
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.support_agent, color: Colors.black, size: 30),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
              ? const Center(child: Text("Data pengguna tidak ditemukan"))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Selamat datang, ",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            Text(
                              userData?['nama'] ?? 'Nama Tidak Ditemukan',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Slideshow tanpa variabel _images
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.9,
                        width: double.infinity,
                        child: PageView(
                          controller: _pageController,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'images/xiaomi14.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'images/s25u.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'images/ip16pro.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.all(13.0),
                        child: Text(
                          'Mulai dengan penampilan baru',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),

                      FutureBuilder<List<Produk>>(
                        future: ProdukBloc.getProduks(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('Tidak ada produk tersedia.'));
                          } else {
                            var produkList = snapshot.data!;
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(12),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: produkList.length,
                              itemBuilder: (context, index) {
                                final produk = produkList[index];
                                return _buildProductCard(context, produk);
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildProductCard(BuildContext context, Produk produk) {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatRupiah(produk.hargaProduk),
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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
