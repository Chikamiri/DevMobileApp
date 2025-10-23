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
        title: const Text('Thêm sách mới'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(
                  labelText: 'Tên sách',
                  prefixIcon: Icon(Icons.book_outlined),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: authorCtrl,
                decoration: const InputDecoration(
                  labelText: 'Tác giả',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: yearCtrl,
                decoration: const InputDecoration(
                  labelText: 'Năm xuất bản',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.save),
            label: const Text('Lưu'),
            onPressed: () {
              _addBook(
                titleCtrl.text.trim(),
                authorCtrl.text.trim(),
                int.tryParse(yearCtrl.text.trim()) ?? 0,
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(Map<String, dynamic> b) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange.shade100,
          child: const Icon(Icons.menu_book, color: Colors.orange),
        ),
        title: Text(
          b['title'] ?? 'Không tên',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${b['author'] ?? 'Không rõ tác giả'} — ${b['year'] ?? ''}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () => _deleteBook(b['id']),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Quản lý Sách',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDialog,
        icon: const Icon(Icons.add),
        label: const Text('Thêm sách'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: _books.isEmpty
            ? const Center(
                child: Text(
                  'Chưa có sách nào trong thư viện',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 80),
                itemCount: _books.length,
                itemBuilder: (_, i) => _buildBookCard(_books[i]),
              ),
      ),
    );
  }
}
