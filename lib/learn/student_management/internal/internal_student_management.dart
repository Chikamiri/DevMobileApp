import 'package:flutter/material.dart';
import 'internal_sinhvien.dart';

class _InternalStudentManagermentState
    extends State<InternalStudentManagerment> {
  final TextEditingController _maController = TextEditingController();
  final TextEditingController _tenController = TextEditingController();
  final TextEditingController _diemController = TextEditingController();

  final List<Sinhvien> _sinhvienList = [];

  Widget _buildInputFields() {
    return Column(
      children: [
        TextField(
          controller: _maController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Mã sinh viên',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _tenController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Tên sinh viên',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _diemController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Điểm tốt nghiệp',
          ),
        ),
      ],
    );
  }

  void _addSinhvien() {
    final ma = _maController.text.trim();
    final ten = _tenController.text.trim();
    final diemText = _diemController.text.trim();

    InternalSinhvien().checkEmpty(ma, ten, diemText, context);
    InternalSinhvien().checkDiem(diemText, context);

    final diem = double.tryParse(diemText);
    setState(() {
      _sinhvienList.add(
        Sinhvien(maSinhvien: ma, tenSinhvien: ten, diemTotnghiep: diem!),
      );
      _maController.clear();
      _tenController.clear();
      _diemController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Quản lý Sinh Viên',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: _buildInputFields(),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _addSinhvien,
                child: const Text(
                  'Thêm sinh viên',
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: _sinhvienList.length,
            itemBuilder: (context, index) {
              final sv = _sinhvienList[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      sv.diemTotnghiep.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  title: Text(
                    '${sv.maSinhvien} - ${sv.tenSinhvien}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text("2000-01-01 00:00:00.000 (Placeholder)"),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class InternalStudentManagerment extends StatefulWidget {
  const InternalStudentManagerment({super.key});

  @override
  State<InternalStudentManagerment> createState() =>
      _InternalStudentManagermentState();
}
