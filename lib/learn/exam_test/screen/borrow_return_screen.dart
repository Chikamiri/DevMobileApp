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
        title: const Text('Mượn sách'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<int>(
              value: bookId,
              items: _books.map((b) {
                return DropdownMenuItem<int>(
                  value: b['id'],
                  child: Text(b['title']),
                );
              }).toList(),
              onChanged: (v) => bookId = v,
              decoration: const InputDecoration(labelText: 'Chọn sách'),
            ),
            DropdownButtonFormField<int>(
              value: memberId,
              items: _members.map((m) {
                return DropdownMenuItem<int>(
                  value: m['id'],
                  child: Text(m['name']),
                );
              }).toList(),
              onChanged: (v) => memberId = v,
              decoration: const InputDecoration(labelText: 'Người mượn'),
            ),
            TextField(
              controller: dateCtrl,
              decoration: const InputDecoration(labelText: 'Ngày mượn'),
            ),
          ],
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
            child: const Text('Mượn'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showBorrowDialog,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
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

          return ListTile(
            title: Text('${book['title']} — ${member['name']}'),
            subtitle: Text(
              'Mượn: ${r['borrow_date']}\nTrả: ${r['return_date'] ?? '-'}',
            ),
            trailing: !returned
                ? TextButton(
                    onPressed: () => _returnBook(r['id']),
                    child: const Text(
                      'Trả',
                      style: TextStyle(color: Colors.green),
                    ),
                  )
                : const Icon(Icons.check, color: Colors.grey),
          );
        },
      ),
    );
  }
}
