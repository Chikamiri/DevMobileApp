import 'package:flutter/material.dart';

class AppbarHandle extends StatelessWidget implements PreferredSizeWidget {
  const AppbarHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white38,
      title: Text(
        'Pay the bill',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
      ),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.keyboard_arrow_left, size: 36),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
