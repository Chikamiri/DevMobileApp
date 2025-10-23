import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../internal/data_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _confirmResetDatabase(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xóa toàn bộ dữ liệu'),
        content: const Text(
          'Bạn có chắc muốn xóa toàn bộ cơ sở dữ liệu không?\n'
          'Hành động này không thể hoàn tác.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(ctx); // đóng dialog
              final db = context.read<DataProvider>().db;
              await db.deleteAndResetDatabase();

              // Làm mới toàn bộ dữ liệu trong app
              await context.read<DataProvider>().refreshAll();

              // Hiển thị thông báo
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Đã xóa toàn bộ dữ liệu và khởi tạo lại database',
                    ),
                  ),
                );
              }
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Cài đặt hệ thống',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 20),

          const ListTile(
            leading: Icon(Icons.info, color: Colors.orange),
            title: Text('Tên ứng dụng'),
            subtitle: Text('Quản lý kho hàng - Mid Exam Test'),
          ),
          const Divider(),

          const ListTile(
            leading: Icon(Icons.storage, color: Colors.orange),
            title: Text('Cơ sở dữ liệu'),
            subtitle: Text(
              'Lưu trữ dữ liệu hàng hóa, nhà cung cấp, khách hàng, phiếu xuất',
            ),
          ),
          const Divider(),

          const ListTile(
            leading: Icon(Icons.developer_mode, color: Colors.orange),
            title: Text('Phiên bản'),
            subtitle: Text('1.0.0'),
          ),
          const SizedBox(height: 30),

          ElevatedButton.icon(
            onPressed: () => _confirmResetDatabase(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            icon: const Icon(Icons.delete_forever),
            label: const Text(
              'Xóa toàn bộ cơ sở dữ liệu',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
