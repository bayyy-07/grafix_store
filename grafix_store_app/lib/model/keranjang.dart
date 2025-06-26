class Keranjang {
  int? id;
  int? userId;
  int? produkId;
  int? jumlah;

  String? color;
  String? namaProduk;
  int? hargaProduk;
  String? image;
  int? rating;
  String? brand;
  String? kategori;
  String? storage;

  Keranjang({
    this.id,
    this.userId,
    this.produkId,
    this.jumlah,
    this.color,
    this.namaProduk,
    this.hargaProduk,
    this.image,
    this.rating,
    this.brand,
    this.kategori,
    this.storage,

  });

  factory Keranjang.fromJson(Map<String, dynamic> obj) {
    return Keranjang(
      id: int.tryParse(obj['id'].toString()),
      userId: int.tryParse(obj['user_id'].toString()),
      produkId: int.tryParse(obj['produk_id'].toString()),
      jumlah: int.tryParse(obj['jumlah'].toString()),

      color: obj['color'],
      namaProduk: obj['name'],
      hargaProduk: int.tryParse(obj['price'].toString()),
      image: obj['image'],
      rating: int.tryParse(obj['rating']?.toString() ?? '0'),
      brand: obj['brand'],
      kategori: obj['kategori'],
      storage: obj['storage'],
    );
  }
}
