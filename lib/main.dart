import 'package:flutter/material.dart';
import 'learn/shop/shop.dart';
//import 'card_practice.dart';
//import 'stateful_practice.dart';
//import 'house_info.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: OrderPage(),
    ),
  );
}
