class Produk {
  int? id;
  String? namaProduk;
  int? hargaProduk;
  String? image;  // Ubah dari List<String> ke String
  int? rating;
  String? brand; 
  String? kategori;
  String? processor;
  String? front_camera;
  String? back_camera;
  String? kamera_wideangle; 
  String? kamera_telephoto; 
  String? kamera_depth; 
  String? sistem_operasi; 
  String? baterai;
  String? ukuran_layar;


  Produk({this.id, 
    this.image, 
    this.namaProduk, 
    this.hargaProduk, 
    this.rating, 
    this.brand, 
    this.kategori, 
    required this.processor,
    required this.front_camera,
    required this.back_camera,
    required this.kamera_wideangle,
    required this.kamera_telephoto,
    required this.kamera_depth,
    required this.sistem_operasi,
    required this.ukuran_layar,
    required this.baterai,
    
    
    
    
    
    });

  factory Produk.fromJson(Map<String, dynamic> obj) {
    print("Data Image dari API: ${obj['image']}");  
    return Produk(
      id: int.tryParse(obj['id'].toString()),
      namaProduk: obj['name'],
      hargaProduk: int.tryParse(obj['price'].toString()),
      rating: int.tryParse(obj['rating'].toString()),
      image: obj['image'] ,  
      brand: obj['brand'] ,  
      kategori: obj['kategori'],
      processor: obj['processor'],
      front_camera: obj['front_camera'],
      back_camera: obj['back_camera'],
      kamera_wideangle: obj['kamera_wideangle'],  
      kamera_telephoto: obj['kamera_telephoto'],  
      kamera_depth: obj['kamera_depth'],  
      sistem_operasi: obj['sistem_operasi'],  
      baterai: obj['baterai'],  
      ukuran_layar: obj['ukuran_layar'],  
    );
  }
}
