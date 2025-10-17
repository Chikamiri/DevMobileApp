import 'package:flutter/material.dart';
import '../internal/db_helper.dart';
import '../internal/session_helper.dart';
import '../wrapper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String? error;

  Future<void> _register() async {
    if (userCtrl.text.isEmpty || passCtrl.text.isEmpty) {
      setState(() => error = 'Vui lòng nhập đủ thông tin');
      return;
    }

    final exists = await DBHelper.getUser(userCtrl.text, passCtrl.text);
    if (exists != null) {
      setState(() => error = 'Tài khoản đã tồn tại');
      return;
    }

    await DBHelper.insertUser(userCtrl.text, passCtrl.text);
    await SessionHelper.saveUser(userCtrl.text);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Wrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký tài khoản')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userCtrl,
              decoration: const InputDecoration(labelText: 'Tên đăng nhập'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Mật khẩu'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Tạo tài khoản'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Quay lại đăng nhập'),
            ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(error!, style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}
