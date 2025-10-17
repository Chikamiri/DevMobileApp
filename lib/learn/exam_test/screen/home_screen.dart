import 'package:flutter/material.dart';
import '../internal/home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.orangeAccent, Colors.white],
        ),
      ),
      child: Center(
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: const [
            HomeCard(icon: Icons.menu_book, label: 'Quản lý Sách'),
            HomeCard(icon: Icons.assignment_return, label: 'Mượn / Trả'),
            HomeCard(icon: Icons.people, label: 'Thành viên'),
            HomeCard(icon: Icons.settings, label: 'Cài đặt'),
          ],
        ),
      ),
    );
  }
}
