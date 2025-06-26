import 'package:flutter/material.dart';
import 'package:grafix_store/model/produk.dart';
import 'package:grafix_store/ui/home_page.dart';
import 'package:grafix_store/ui/shop_page.dart';

import 'package:lucide_icons/lucide_icons.dart';
import 'package:grafix_store/bloc/produk_bloc.dart';
import 'package:intl/intl.dart';
import 'package:grafix_store/ui/detail_produk.dart';

class PenawaranPage extends StatelessWidget {
  const PenawaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'images/logo.png',
          height: 120,
        ),
        actions: [
         IconButton(
            icon: const Icon(Icons.support_agent, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: const [
          PromoCard(
            imagePath: 'images/vivoxfold3.jpg',
            title: 'Vivo X Fold 3',
            cashbackText: 'Total Cashback\nhingga Rp4 juta',
            backgroundColor: Colors.white,
            textColor: Colors.black,
            buttonColor: Colors.black,
            buttonTextColor: Colors.white,
          ),
          PromoCard(
            imagePath: 'images/oppofindxb8.png',
            title: 'Oppo Find X8 Pro',
            cashbackText: 'Total Cashback\nhingga Rp3 juta',
            backgroundColor: Colors.black,
            textColor: Colors.white,
            buttonColor: Colors.white,
            buttonTextColor: Colors.black,
          ),
        ],
      ),
    );
  }
}

class PromoCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String cashbackText;
  final Color backgroundColor;
  final Color textColor;
  final Color buttonColor;
  final Color buttonTextColor;

  const PromoCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.cashbackText,
    required this.backgroundColor,
    required this.textColor,
    required this.buttonColor,
    required this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.7)),
          ),
          const SizedBox(height: 8),
          Text(
            cashbackText,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Bonus e-Voucher Rp 500 ribu untuk pembelian\npertama di Grafix Store. Hingga 31 Des 2025',
            style: TextStyle(fontSize: 14, color: textColor),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShopPage(),
          ),
        );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            ),
            child: Text(
              'Beli Sekarang',
              style: TextStyle(color: buttonTextColor, fontSize: 16),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
