import 'package:flutter/material.dart';
import 'screen/homepage_screen.dart';
import 'screen/products_screen.dart';
import 'screen/suppliers_screen.dart';
import 'screen/customers_screen.dart';
import 'screen/imports_screen.dart';
import 'screen/exports_screen.dart';
import 'screen/settings_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ProductsScreen(),
    SuppliersScreen(),
    CustomersScreen(),
    ImportsScreen(),
    ExportsScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          [
            "Trang chủ",
            "Quản lý hàng hóa",
            "Nhà cung cấp",
            "Khách hàng",
            "Nhập hàng",
            "Xuất hàng",
            "Cài đặt",
          ][_selectedIndex],
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Hàng hóa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.factory),
            label: 'Nhà cung cấp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Khách hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Nhập hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Xuất hàng',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
        ],
      ),
    );
  }
}
