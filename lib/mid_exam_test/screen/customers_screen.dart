import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../internal/data_provider.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  List<Map<String, dynamic>> customers = [];

  Future<void> _loadCustomers(BuildContext context) async {
    final db = context.read<DataProvider>().db;
    final list = await db.getCustomers();
    setState(() => customers = list);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCustomers(context);
    });
  }

  void _showAddOrEditDialog(
    BuildContext context, {
    Map<String, dynamic>? data,
  }) {
    final codeCtrl = TextEditingController(text: data?['code'] ?? '');
    final nameCtrl = TextEditingController(text: data?['name'] ?? '');
    final addrCtrl = TextEditingController(text: data?['address'] ?? '');
    final phoneCtrl = TextEditingController(text: data?['phone'] ?? '');
    final isEdit = data != null;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Chỉnh sửa khách hàng' : 'Thêm khách hàng'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: codeCtrl,
                decoration: const InputDecoration(labelText: 'Mã khách hàng'),
              ),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Tên khách hàng'),
              ),
              TextField(
                controller: addrCtrl,
                decoration: const InputDecoration(labelText: 'Địa chỉ'),
              ),
              TextField(
                controller: phoneCtrl,
                decoration: const InputDecoration(labelText: 'Số điện thoại'),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameCtrl.text.trim();
              if (name.isEmpty) return;

              final payload = {
                'code': codeCtrl.text.trim(),
                'name': name,
                'address': addrCtrl.text.trim(),
                'phone': phoneCtrl.text.trim(),
              };

              final db = context.read<DataProvider>().db;
              if (isEdit) {
                await db.updateCustomer(data['id'], payload);
              } else {
                await db.insertCustomer(payload);
              }

              if (mounted) {
                Navigator.pop(ctx);
                _loadCustomers(context);
                context.read<DataProvider>().refreshAll();
              }
            },
            child: Text(isEdit ? 'Lưu' : 'Thêm'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xóa khách hàng'),
        content: const Text('Bạn có chắc muốn xóa khách hàng này không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              final db = context.read<DataProvider>().db;
              await db.deleteCustomer(id);
              if (mounted) {
                Navigator.pop(ctx);
                _loadCustomers(context);
                context.read<DataProvider>().refreshAll();
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _loadCustomers(context),
        child: customers.isEmpty
            ? const Center(child: Text('Chưa có khách hàng nào'))
            : ListView.builder(
                itemCount: customers.length,
                itemBuilder: (context, i) {
                  final c = customers[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.orange),
                      title: Text('${c['code'] ?? '-'} - ${c['name']}'),
                      subtitle: Text(
                        'Địa chỉ: ${c['address'] ?? 'Không có'}\n'
                        'SĐT: ${c['phone'] ?? 'Không có'}',
                      ),
                      isThreeLine: true,
                      trailing: PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          if (value == 'edit') {
                            _showAddOrEditDialog(context, data: c);
                          } else if (value == 'delete') {
                            _confirmDelete(context, c['id']);
                          }
                        },
                        itemBuilder: (ctx) => const [
                          PopupMenuItem(
                            value: 'edit',
                            child: Text('Chỉnh sửa'),
                          ),
                          PopupMenuItem(value: 'delete', child: Text('Xóa')),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddOrEditDialog(context),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
