class ApiUrl {
  // Base URL tanpa trailing slash, akan ditambahkan di setiap endpoint.
  // Uri.parse('http://10.0.2.2/grafix_API/public/'), --Emulator android
  static const String baseUrl = 'http://192.168.96.114/grafix_API/public';

  // Path untuk gambar produk
   static String gambarProduk(String path) {
    return '$baseUrl$path';
  }


  // Endpoint untuk registrasi dan login
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';

  // Endpoint untuk list produk dan create produk
  static const String listProduk = baseUrl + '/produk';
  static const String createProduk = baseUrl + '/produk';

  // Endpoint untuk update produk dengan ID
  static String updateProduk(int id) {
    return baseUrl + '/produk/' + id.toString() + '/update';
  }

  // Endpoint untuk mendapatkan produk berdasarkan ID
  static String showProduk(int id) {
    return baseUrl + '/produk/' + id.toString();
  }

  // Endpoint untuk menghapus produk berdasarkan ID
  static String deleteProduk(int id) {
    return baseUrl + '/produk/' + id.toString();
  }

  // Endpoint untuk menghapus produk berdasarkan ID
  static String getProduk(int id) {
    return baseUrl + '/produk/' + id.toString();
  }




  // Endpoint keranjang
  static const String keranjang = baseUrl + '/keranjang';
  static const String keranjangTambah = baseUrl + '/keranjang/tambah';  // Endpoint untuk tambah item ke keranjang

   //untuk ambil profil berdasarkan token
  static const String getProfile = baseUrl + '/profile';

   // Untuk mengambil data service user service (GET)
  static const String getService = baseUrl + '/service';
  // Untuk menambahkan data service (POST)
  static const String postService = baseUrl + '/service/tambah';
  
  // Midtrans
  static const String paymentToken = baseUrl + '/payment/token';

}
