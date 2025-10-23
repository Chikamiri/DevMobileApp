import 'package:flutter/material.dart';
import '../internal/db_helper.dart';

class BorrowReturnScreen extends StatefulWidget {
  const BorrowReturnScreen({super.key});

  @override
  State<BorrowReturnScreen> createState() => _BorrowReturnScreenState();
}

class _BorrowReturnScreenState extends State<BorrowReturnScreen> {
  List<Map<String, dynamic>> _records = [];
  List<Map<String, dynamic>> _books = [];
  List<Map<String, dynamic>> _members = [];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    _books = await DBHelper.query('books');
    _members = await DBHelper.query('members');
    _records = await DBHelper.query('borrow_records');
    setState(() {});
  }

  Future<void> _addRecord(int bookId, int memberId, String borrowDate) async {
    await DBHelper.insert('borrow_records', {
      'book_id': bookId,
      'member_id': memberId,
      'borrow_date': borrowDate,
      'return_date': '',
    });
    _refresh();
  }

  Future<void> _returnBook(int id) async {
    await DBHelper.update('borrow_records', {
      'return_date': DateTime.now().toIso8601String(),
    }, id);
    _refresh();
  }

  void _showBorrowDialog() {
    int? bookId;
    int? memberId;
    final dateCtrl = TextEditingController(
      text: DateTime.now().toIso8601String().split('T').first,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Thêm phiếu mượn'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                items: _books
                    .map<DropdownMenuItem<int>>(
                      (b) => DropdownMenuItem<int>(
                        value: b['id'] as int,
                        child: Text(b['title']),
                      ),
                    )
                    .toList(),
                onChanged: (v) => bookId = v,
                decoration: const InputDecoration(labelText: 'Chọn sách'),
              ),
              DropdownButtonFormField<int>(
                items: _members
                    .map<DropdownMenuItem<int>>(
                      (m) => DropdownMenuItem<int>(
                        value: m['id'] as int,
                        child: Text(m['name']),
                      ),
                    )
                    .toList(),
                onChanged: (v) => memberId = v,
                decoration: const InputDecoration(labelText: 'Người mượn'),
              ),

              TextField(
                controller: dateCtrl,
                decoration: const InputDecoration(labelText: 'Ngày mượn'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (bookId != null && memberId != null) {
                _addRecord(bookId!, memberId!, dateCtrl.text);
              }
              Navigator.pop(context);
            },
            child: const Text('Xác nhận'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text(
          'Mượn / Trả Sách',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showBorrowDialog,
        icon: const Icon(Icons.add),
        label: const Text('Mượn sách'),
      ),
      body: _records.isEmpty
          ? const Center(child: Text('Chưa có bản ghi mượn trả nào'))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _records.length,
              itemBuilder: (_, i) {
                final r = _records[i];
                final book = _books.firstWhere(
                  (b) => b['id'] == r['book_id'],
                  orElse: () => {'title': 'N/A'},
                );
                final member = _members.firstWhere(
                  (m) => m['id'] == r['member_id'],
                  orElse: () => {'name': 'N/A'},
                );
                final returned = (r['return_date'] ?? '').isNotEmpty;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 4,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(
                      returned ? Icons.check_circle : Icons.book_outlined,
                      color: returned ? Colors.grey : Colors.orange,
                    ),
                    title: Text(
                      book['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Người mượn: ${member['name']}\n'
                      'Mượn: ${r['borrow_date']}\n'
                      'Trả: ${r['return_date']?.isNotEmpty == true ? r['return_date'] : '-'}',
                    ),
                    trailing: returned
                        ? const Icon(Icons.check, color: Colors.grey)
                        : TextButton(
                            onPressed: () => _returnBook(r['id']),
                            child: const Text(
                              'Trả',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                  ),
                );
              },
            ),
    );
  }
}
