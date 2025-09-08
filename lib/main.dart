import 'package:flutter/material.dart';

//import 'card_practice.dart';
import 'house_info.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          //   appBar: AppBar(
          //     backgroundColor: Colors.white38,

          //     leading: IconButton(
          //       onPressed: () {},
          //       icon: const Icon(Icons.keyboard_arrow_left, size: 36),
          //     ),
          //     actions: [
          //       IconButton(
          //         onPressed: () {},
          //         icon: const Icon(Icons.favorite_outline, size: 36),
          //       ),
          //     ],
          //   ),
          body: HouseInfo(),
        ),
      ),
    ),
  );
}
