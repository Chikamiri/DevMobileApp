import 'package:flutter/material.dart';
import 'homepage.dart';

class MyThongKe extends StatelessWidget {
  const MyThongKe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Đây là trang thống kê")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Quay lại trang chủ"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          },
        ),
      ),
    );
  }
}
