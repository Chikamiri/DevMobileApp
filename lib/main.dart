import 'package:flutter/material.dart';
import 'learn/exam_test/screen/startup_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const StartupScreen(),
    ),
  );
}
