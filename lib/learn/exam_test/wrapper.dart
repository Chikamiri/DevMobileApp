import 'package:flutter/material.dart';
import 'screen/home_screen.dart';
import 'screen/books_screen.dart';
import 'screen/borrow_return_screen.dart';
import 'screen/members_screen.dart';
import 'screen/settings_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _index = 0;

  final _pages = const [
    HomeScreen(),
    BooksScreen(),
    MembersScreen(),
    BorrowReturnScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Sách'),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Thành viên',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Mượn/Trả'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
        ],
      ),
    );
  }
}
