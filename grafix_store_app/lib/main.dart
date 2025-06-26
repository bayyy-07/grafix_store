import 'package:flutter/material.dart';
import 'package:grafix_store/ui/home_page.dart';
import 'package:grafix_store/ui/login_page.dart';
import 'package:grafix_store/helpers/user_info.dart';
import 'package:grafix_store/ui/detail_kerusakan.dart';
import 'package:grafix_store/ui/compare_selection_page.dart';
import 'package:grafix_store/ui/compare_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grafix Store',
      debugShowCheckedModeBanner: false,
      routes: {
    '/loginPage': (context) => const LoginPage(),
    '/homePage': (context) => const HomePage(),
    
  },


      home: FutureBuilder<bool>(
        future: _checkLoginStatus(), // Memeriksa status login
        builder: (context, snapshot) {
          // Tampilkan indikator loading saat memeriksa login status
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Jika ada error saat memeriksa login status
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('Error loading login status')),
            );
          }

          // Jika status login valid, arahkan ke HomePage, jika tidak, LoginPage
          if (snapshot.data == true) {
            return const HomePage();  // Pengguna sudah login
          } else {
            return const LoginPage(); // Pengguna belum login
          }
        },
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
  var token = await UserInfo().getToken();
  var userId = await UserInfo().getUserID();
  print("Startup Token: $token");
  print("Startup UserID: $userId");
  return token != null && userId != null;
}

}
