import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../internal/data_provider.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  List<Map<String, dynamic>> suppliers = [];

  Future<void> _loadSuppliers(BuildContext context) async {
    final db = context.read<DataProvider>().db;
    final list = await db.getSuppliers();
    setState(() => suppliers = list);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSuppliers(context);
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
        title: Text(isEdit ? 'Chỉnh sửa nhà cung cấp' : 'Thêm nhà cung cấp'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: codeCtrl,
                decoration: const InputDecoration(labelText: 'Mã nhà cung cấp'),
              ),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Tên nhà cung cấp',
                ),
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
                await context.read<DataProvider>().db.updateSupplier(
                  data['id'],
                  payload,
                );
              } else {
                await db.insertSupplier(payload);
              }

              if (mounted) {
                Navigator.pop(ctx);
                _loadSuppliers(context);
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
        title: const Text('Xóa nhà cung cấp'),
        content: const Text('Bạn có chắc muốn xóa nhà cung cấp này không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              final db = context.read<DataProvider>().db;
              await db.deleteSupplier(id);
              if (mounted) {
                Navigator.pop(ctx);
                _loadSuppliers(context);
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

  void _showAddProductDialog(BuildContext context, int supplierId) {
    final nameCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();
    final priceCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nhập hàng mới'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Tên hàng hóa'),
            ),
            TextField(
              controller: qtyCtrl,
              decoration: const InputDecoration(labelText: 'Số lượng'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: priceCtrl,
              decoration: const InputDecoration(labelText: 'Giá bán'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameCtrl.text.trim();
              final qty = int.tryParse(qtyCtrl.text) ?? 0;
              final price = double.tryParse(priceCtrl.text) ?? 0;

              if (name.isEmpty || qty <= 0) return;

              await context.read<DataProvider>().addProduct({
                'name': name,
                'quantity': qty,
                'price': price,
                'supplierId': supplierId,
              });

              if (mounted) {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã nhập hàng thành công')),
                );
              }
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _loadSuppliers(context),
        child: suppliers.isEmpty
            ? const Center(child: Text('Chưa có nhà cung cấp nào'))
            : ListView.builder(
                itemCount: suppliers.length,
                itemBuilder: (context, i) {
                  final s = suppliers[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.factory, color: Colors.orange),
                      title: Text('${s['code'] ?? '-'} - ${s['name']}'),
                      subtitle: Text(
                        'Địa chỉ: ${s['address'] ?? 'Không có'}\nSĐT: ${s['phone'] ?? 'Không có'}',
                      ),
                      isThreeLine: true,
                      trailing: PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          if (value == 'edit') {
                            _showAddOrEditDialog(context, data: s);
                          } else if (value == 'delete') {
                            _confirmDelete(context, s['id']);
                          } else if (value == 'addProduct') {
                            _showAddProductDialog(context, s['id']);
                          }
                        },
                        itemBuilder: (ctx) => [
                          const PopupMenuItem(
                            value: 'addProduct',
                            child: Text('Nhập hàng mới'),
                          ),
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Chỉnh sửa'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Xóa'),
                          ),
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
