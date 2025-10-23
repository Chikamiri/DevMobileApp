import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mid_exam_test/wrapper.dart';
import 'mid_exam_test/internal/data_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DataProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    ),
  );
}
