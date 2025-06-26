import 'package:flutter/material.dart';
import 'package:grafix_store/helpers/api.dart';

class DetailKerusakanPage extends StatefulWidget {
  @override
  _DetailKerusakanPageState createState() => _DetailKerusakanPageState();
}

class _DetailKerusakanPageState extends State<DetailKerusakanPage> {
  Map<String, dynamic>? serviceData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadServiceData();
  }

  Future<void> loadServiceData() async {
    final api = Api();
    final data = await api.fetchService();
    setState(() {
      serviceData = data;
      isLoading = false;
    });
  }

  Widget buildTextField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 4),
        TextField(
          controller: TextEditingController(text: value),
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Detail Kerusakan")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (serviceData == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Detail Kerusakan")),
        body: Center(child: Text("Gagal memuat data")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Perbaikan"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField("Nomor Seri", serviceData!['no_seri']),
            buildTextField("Perangkat", serviceData!['perangkat']),
            buildTextField("Tipe Handphone", serviceData!['merek_perangkat']),
            buildTextField("Layanan Yang Dipilih", serviceData!['pelayanan']),
            buildTextField("Jenis Perbaikan", serviceData!['jenis_kerusakan']),
            Text("Deskripsi Kerusakan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            SizedBox(height: 4),
            TextField(
              controller: TextEditingController(text: serviceData!['detail_kerusakan']),
              readOnly: true,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Tambahkan logika cetak invoice di sini
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Cetak Invoice"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
