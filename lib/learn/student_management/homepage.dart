import 'package:flutter/material.dart';
import 'thongke.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đây là trang chủ"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Chuyển sang trang thống kê"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyThongKe()),
            );
          },
        ),
      ),
    );
  }
}
