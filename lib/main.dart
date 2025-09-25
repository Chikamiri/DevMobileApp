import 'package:flutter/material.dart';

//import 'card_practice.dart';
//import 'stateful_practice.dart';
//import 'house_info.dart';
import 'student_managerment.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          //   ),
          body: StudentManagerment(),
        ),
      ),
    ),
  );
}
