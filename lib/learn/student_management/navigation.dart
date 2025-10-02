import 'package:app/learn/student_management/internal/sinhvien_tab.dart';
import 'package:flutter/material.dart';
import 'internal/student_managerment.dart';

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Dùng nguyên bản class trong 3 file internal
    _pages = const [
      StudentManagerment(),
      SinhVienTab(),
      Center(child: Text("Quản lý nâng cao")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          [
            "Quản lý sinh viên",
            "Sinh viên",
            "Quản lý nâng cao",
          ][currentPageIndex],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: 'QL Sinh viên',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Sinh viên',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'QL nâng cao',
          ),
        ],
      ),
      body: _pages[currentPageIndex],
    );
  }
}
