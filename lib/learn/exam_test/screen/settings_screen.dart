import 'package:flutter/material.dart';
import 'login.dart';
import '../internal/session_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _logout(BuildContext context) async {
    await SessionHelper.clearUser();
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text('Cài đặt'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.orange),
                title: const Text('Tài khoản'),
                subtitle: const Text('Quản lý thông tin người dùng'),
                onTap: () {
                  // Có thể mở màn hình thông tin người dùng ở đây
                },
              ),
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.palette, color: Colors.orange),
                title: const Text('Giao diện'),
                subtitle: const Text('Tùy chọn màu sắc và chủ đề'),
                onTap: () {
                  // Placeholder cho tùy chỉnh theme
                },
              ),
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.info, color: Colors.orange),
                title: const Text('Thông tin ứng dụng'),
                subtitle: const Text('Phiên bản và nhà phát triển'),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Quản lý Thư viện',
                    applicationVersion: '1.0.0',
                    applicationIcon: const Icon(Icons.menu_book),
                    children: const [
                      Text('Ứng dụng quản lý thư viện — Flutter & SQLite.'),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 156, 156),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout),
                label: const Text('Đăng xuất', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
