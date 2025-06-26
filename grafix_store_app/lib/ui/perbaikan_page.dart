import 'package:flutter/material.dart';

import 'package:grafix_store/helpers/api.dart';
import 'package:grafix_store/ui/detail_kerusakan.dart';



class PerbaikanPage extends StatefulWidget {
  const PerbaikanPage({super.key});

  @override
  State<PerbaikanPage> createState() => _PerbaikanPageState();
}

class _PerbaikanPageState extends State<PerbaikanPage> {
  String? selectedPerangkat;
  String? selectedPelayanan;
  String? selectedKerusakan;
  final TextEditingController merekController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();

 final perangkatOptions = <Map<String, Object>>[
  {"label": "Smartphone", "icon": Icons.smartphone},
  {"label": "Laptop", "icon": Icons.laptop},
  {"label": "TV", "icon": Icons.tv},
];

final pelayananOptions = <Map<String, Object>>[
  {"label": "Garansi", "icon": Icons.verified_user},
  {"label": "Perbaikan", "icon": Icons.build},
];

final kerusakanOptions = <Map<String, Object>>[
  {"label": "Layar retak", "icon": Icons.phone_android},
  {"label": "Tombol tidak berfungsi", "icon": Icons.radio_button_checked},
  {"label": "Servis baterai", "icon": Icons.battery_alert},
  {"label": "Kamera tidak berfungsi", "icon": Icons.camera_alt},
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dukungan Perbaikan"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bantuan apa yang anda butuhkan?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildSectionTitle("Perangkat"),
            ...perangkatOptions.map((item) =>
                _buildSelectableButton(item["icon"]  as IconData, item["label"] as String, selectedPerangkat, (val) {
                  setState(() => selectedPerangkat = val);
                })),

            const SizedBox(height: 20),
            _buildSectionTitle("Pelayanan"),
            ...pelayananOptions.map((item) =>
              _buildSelectableButton(item["icon"] as IconData, item["label"] as String, selectedPelayanan, (val) {
                setState(() => selectedPelayanan = val);
              })),


            const SizedBox(height: 20),
            _buildSectionTitle("Perbaikan Dan Kerusakan"),
            ...kerusakanOptions.map((item) =>
                _buildSelectableButton(item["icon"]  as IconData, item["label"] as String, selectedKerusakan, (val) {
                  setState(() => selectedKerusakan = val);
                })),

             const SizedBox(height: 28),
            _buildSectionTitle("Merek Perangkat"),
            const SizedBox(height: 7),
            TextField(
              controller: merekController,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "Contoh : Samsung",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 28),
            _buildSectionTitle("Sampaikan detail kerusakan"),
            const SizedBox(height: 7),
            TextField(
              controller: deskripsiController,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "Jelaskan secara detail",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle("Masukan nomor seri untuk validasi produk"),
            const SizedBox(height: 7),
            TextField(
              controller: serialNumberController,
              decoration: InputDecoration(
                hintText: "Masukan nomor seri",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Lanjutkan", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255))),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontWeight: FontWeight.bold));
  }

  Widget _buildSelectableButton(IconData icon, String label, String? selectedValue, ValueChanged<String> onTap) {
    final isSelected = selectedValue == label;
    return GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.black : Colors.black45),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.black12 : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

 void _handleSubmit() async {
  if (selectedPerangkat == null ||
      selectedPelayanan == null ||
      selectedKerusakan == null ||
      serialNumberController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Mohon lengkapi semua data terlebih dahulu.")),
    );
    return;
  }

  final api = Api();
  final success = await api.createService(
    noSeri: serialNumberController.text.trim(),
    perangkat: selectedPerangkat!,
    merekPerangkat: merekController.text.trim(),
    pelayanan: selectedPelayanan!,
    jenisKerusakan: selectedKerusakan!,
    detailKerusakan: deskripsiController.text.trim(),
  );

  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data berhasil dikirim.")),
    );
   Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => DetailKerusakanPage()),
);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Gagal mengirim data. Coba lagi.")),
    );
  }
}
}
