import 'package:flutter/material.dart';

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

class InternalStudentManagerment extends StatefulWidget {
  const InternalStudentManagerment({super.key});

  @override
  State<InternalStudentManagerment> createState() =>
      _InternalStudentManagermentState();
}

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
    if (_maController.text.isEmpty ||
        _tenController.text.isEmpty ||
        _diemController.text.isEmpty) {
      return;
    }

    setState(() {
      _sinhvienList.add(
        Sinhvien(
          maSinhvien: _maController.text,
          tenSinhvien: _tenController.text,
          diemTotnghiep: double.tryParse(_diemController.text) ?? 0,
        ),
      );
      // clear input sau khi thêm
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
              ElevatedButton(
                onPressed: _addSinhvien,
                child: const Text('Thêm Sinh Viên'),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: _sinhvienList.length,
            itemBuilder: (context, index) {
              final sv = _sinhvienList[index];
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(sv.tenSinhvien),
                subtitle: Text(
                  'MSSV: ${sv.maSinhvien} - Điểm: ${sv.diemTotnghiep}',
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              );
            },
          ),
        ),
      ],
    );
  }
}
