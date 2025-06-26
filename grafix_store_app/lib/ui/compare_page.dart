import 'package:flutter/material.dart';
import 'package:grafix_store/model/produk.dart';
import 'package:grafix_store/helpers/api.dart';

class CompareResultPage extends StatelessWidget {
  final Produk produk1;
  final int produk2Id;

  const CompareResultPage({required this.produk1, required this.produk2Id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hasil Perbandingan')),
      body: FutureBuilder<Produk?>(
        
        future: Api().fetchProdukById(produk2Id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Produk pembanding tidak ditemukan.'));
          }

          final produk2 = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Perbandingan antara\n${produk1.namaProduk} & ${produk2.namaProduk}',
                textAlign: TextAlign.center,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildProdukCard(produk1)),
                    SizedBox(width: 16),
                    Expanded(child: _buildProdukCard(produk2)),
                  ],
                ),
                SizedBox(height: 20),

                  
                

                _buildSpecSection(
                  title: "KAMERA DEPAN",
                  iconAssetLeft: 'images/kamera_depan.png',
                  iconAssetRight: 'images/kamera_depan.png',
                 
                  specs: [
                    {"label": "Kamera Utama", "val1": produk1.front_camera ?? "", "val2": produk2.front_camera ?? ""},
                  ],
                ),

                _buildSpecSection(
                  title: "KAMERA BELAKANG",
                  iconAssetLeft: 'images/kamera_belakang_kiri.png',
                  iconAssetRight: 'images/kamera_belakang_kanan.png',
                  specs: [
                    {"label": "Kamera Utama", "val1": produk1.back_camera ?? "", "val2": produk2.back_camera ?? ""},
                    {"label": "Kamera Wideangle", "val1": produk1.kamera_wideangle ?? "", "val2": produk2.kamera_wideangle ?? ""},
                    {"label": "Kamera Telephoto", "val1": produk1.kamera_telephoto ?? "", "val2": produk2.kamera_telephoto ?? ""},
                  ],
                ),

                 _buildSpecSection(
                  title: "DIMENSI LAYAR",
                  iconAssetLeft: 'images/dimensi_layar_kiri.png',
                  iconAssetRight: 'images/dimensi_layar_kanan.png',
                  specs: [
                    {"label": "", "val1": produk1.ukuran_layar ?? "", "val2": produk2.ukuran_layar ?? "", },
                    
                  ],
                  
                ),

                _buildSpecSection(
                  title: "BATERAI",
                  iconAssetLeft: 'images/baterai.png',
                  iconAssetRight: 'images/baterai.png',
                 
                  specs: [
                    {"label": "Baterai", "val1": produk1.baterai ?? "", "val2": produk2.baterai ?? ""},
                  ],
                ),

                _buildSpecSection(
                  title: "PROCESSOR",
                  iconAssetLeft: 'images/processor.png',
                  iconAssetRight: 'images/processor.png',
                 
                  specs: [
                    {"label": "Processor", "val1": produk1.processor ?? "", "val2": produk2.processor ?? ""},
                  ],
                ),
                

                
              ],
            ),
          );
        },
      ),
    );
  }

 Widget _buildProdukCard(Produk produk) {
  return SizedBox(
    height: 260, // Tinggi tetap untuk card
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1, // Gambar kotak (1:1)
            child: Image.asset(
              'images/${produk.image}',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Column(
              children: [
                Text(
                  produk.namaProduk ?? 'Tidak ada nama',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  'Rp ${produk.hargaProduk}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


 Widget _buildSpecSection({
  required String title,
  required String iconAssetLeft,
  required String iconAssetRight,
  required List<Map<String, String>> specs,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      SizedBox(height: 3),
      Center(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold))),
      SizedBox(height: 1),
      ...specs.map((spec) {
        final val1 = spec['val1'] ?? '-';
        final val2 = spec['val2'] ?? '-';
        final label = spec['label'] ?? '-';

        final int1 = _extractNumber(val1);
        final int2 = _extractNumber(val2);

        final isVal1Better = int1 > int2;
        final isVal2Better = int2 > int1;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset(iconAssetLeft, height: 30),
                        SizedBox(height: 2),
                        Text(label, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()), 
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset(iconAssetRight, height: 30),
                        SizedBox(height: 2),
                        Text(label, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      val1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: isVal1Better ? Colors.blue : Colors.black,
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()), 
                  Expanded(
                    child: Text(
                      val2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: isVal2Better ? Colors.blue : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    ],
  );
}


  int _extractNumber(String text) {
    try {
      final numericString = RegExp(r'\d+').stringMatch(text);
      return int.parse(numericString ?? '0');
    } catch (_) {
      return 0;
    }
  }
}
