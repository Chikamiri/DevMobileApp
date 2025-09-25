import 'package:flutter/material.dart';

class Sinhvien {
  final String maSinhvien;
  final String tenSinhvien;
  final double diemTotnghiep;

  Sinhvien({
    required this.maSinhvien,
    required this.tenSinhvien,
    required this.diemTotnghiep,
  });
}

class InternalSinhvien {
  void checkEmpty(
    String ma,
    String ten,
    String diemText,
    BuildContext context,
  ) {
    if (ma.isEmpty || ten.isEmpty || diemText.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Không được để trống!')));
      return;
    }
  }

  void checkDiem(String diemText, BuildContext context) {
    final diem = double.tryParse(diemText);
    if (diem == null || diem < 0 || diem > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Điểm phải là số từ 0 đến 10!')),
      );
      return;
    }
  }
}
