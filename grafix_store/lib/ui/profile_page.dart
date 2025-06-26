import 'package:flutter/material.dart';
import 'package:grafix_store/helpers/api.dart'; 
import 'package:grafix_store/helpers/user_info.dart';
import 'package:grafix_store/ui/perbaikan_page.dart';




class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final data = await Api.UserProfile();  // Memanggil API untuk mengambil profil pengguna
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
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Akun", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: userData == null
          ? const Center(child: Text("Data pengguna tidak ditemukan"))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.person, size: 70),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData?['nama'] ?? 'Nama Tidak Ditemukan',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const Text("Member", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  buildProfileMenu(Icons.inventory, "Pesanan", () {}),
                  buildProfileMenu(Icons.settings, "Pengaturan", () {}),
                  buildProfileMenu(Icons.support_agent, "Bantuan Pelanggan", () {}),
                  buildProfileMenu(Icons.build, "Dukungan Perbaikan", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PerbaikanPage()),
                    );
                  }),
                  const SizedBox(height: 24),
                  Center(
                    child: OutlinedButton(
                      onPressed: () async {
                        // Fungsi logout
                       await UserInfo().logout();  // Melakukan logout dan menghapus data
                        final storedTokenAfterLogout = await UserInfo().getToken();
                        final storedUserIDAfterLogout = await UserInfo().getUserID();

                        print("Token setelah logout: $storedTokenAfterLogout");
                        print("UserID setelah logout: $storedUserIDAfterLogout");
                        Navigator.pushReplacementNamed(context, '/loginPage');
                      },
                      child: const Text("Keluar", style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildProfileMenu(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
