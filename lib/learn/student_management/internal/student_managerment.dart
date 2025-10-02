import 'package:flutter/material.dart';
import 'internal_student_management.dart';

class StudentManagerment extends StatelessWidget {
  const StudentManagerment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý sinh viên'),
        backgroundColor: Colors.deepOrange,
      ),
      body: const InternalStudentManagerment(),
    );
  }
}
