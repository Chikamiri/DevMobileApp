import 'package:flutter/material.dart';
import '../internal/db_helper.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  List<Map<String, dynamic>> _books = [];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final data = await DBHelper.query('books');
    setState(() => _books = data);
  }

  Future<void> _addBook(String title, String author, int year) async {
    await DBHelper.insert('books', {
      'title': title,
      'author': author,
      'year': year,
    });
    _refresh();
  }

  Future<void> _deleteBook(int id) async {
    await DBHelper.delete('books', id);
    _refresh();
  }

  void _showAddDialog() {
    final titleCtrl = TextEditingController();
    final authorCtrl = TextEditingController();
    final yearCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Thêm sách'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Tên sách'),
            ),
            TextField(
              controller: authorCtrl,
              decoration: const InputDecoration(labelText: 'Tác giả'),
            ),
            TextField(
              controller: yearCtrl,
              decoration: const InputDecoration(labelText: 'Năm xuất bản'),
              keyboardType: TextInputType.number,
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
              _addBook(
                titleCtrl.text,
                authorCtrl.text,
                int.tryParse(yearCtrl.text) ?? 0,
              );
              Navigator.pop(context);
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _books.length,
        itemBuilder: (_, i) {
          final b = _books[i];
          return ListTile(
            title: Text(b['title']),
            subtitle: Text('${b['author']} (${b['year']})'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteBook(b['id']),
            ),
          );
        },
      ),
    );
  }
}
