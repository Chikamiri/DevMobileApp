import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../internal/data_provider.dart';
import '../internal/db_helper.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late DatabaseHelper db;

  @override
  void initState() {
    super.initState();
    db = context.read<DataProvider>().db;
  }

  // ================= ADD PRODUCT =================
  Future<void> _showAddDialog() async {
    final nameCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();
    final priceCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thêm hàng hóa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Tên hàng'),
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
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () async {
              if (nameCtrl.text.isEmpty) return;
              final name = nameCtrl.text.trim();
              final qty = int.tryParse(qtyCtrl.text) ?? 0;
              final price = double.tryParse(priceCtrl.text) ?? 0.0;

              // kiểm tra xem sản phẩm đã tồn tại chưa
              final existing = await db.database.then(
                (db) =>
                    db.query('products', where: 'name = ?', whereArgs: [name]),
              );

              if (existing.isNotEmpty) {
                // nếu đã có, cộng thêm số lượng
                final id = existing.first['id'] as int;
                final currentQty = existing.first['quantity'] as int;
                await db.updateProduct(id, {
                  'quantity': currentQty + qty,
                  'price': price,
                });
              } else {
                // nếu chưa có, thêm mới
                await db.insertProduct({
                  'name': name,
                  'quantity': qty < 0 ? 0 : qty,
                  'price': price,
                  'supplierId': null,
                });
              }

              await context.read<DataProvider>().refreshAll();
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  // ================= EDIT PRODUCT =================
  Future<void> _showEditDialog(Map<String, dynamic> product) async {
    final nameCtrl = TextEditingController(text: product['name']);
    final qtyCtrl = TextEditingController(text: product['quantity'].toString());
    final priceCtrl = TextEditingController(text: product['price'].toString());

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chỉnh sửa hàng hóa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Tên hàng'),
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
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () async {
              final newQty = int.tryParse(qtyCtrl.text) ?? 0;
              final safeQty = newQty < 0 ? 0 : newQty;
              await db.updateProduct(product['id'], {
                'name': nameCtrl.text,
                'quantity': safeQty,
                'price': double.tryParse(priceCtrl.text) ?? 0.0,
                'supplierId': product['supplierId'],
              });
              await context.read<DataProvider>().refreshAll();
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  // ================= DELETE PRODUCT =================
  Future<void> _deleteProduct(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc muốn xóa hàng hóa này không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await db.deleteProduct(id);
      await context.read<DataProvider>().refreshAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, _) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: provider.db.getProducts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final products = snapshot.data!;
            if (products.isEmpty) {
              return Scaffold(
                body: const Center(child: Text('Chưa có hàng hóa')),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.orange,
                  onPressed: _showAddDialog,
                  child: const Icon(Icons.add),
                ),
              );
            }

            return Scaffold(
              body: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, i) {
                  final item = products[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      title: Text(item['name']),
                      subtitle: Text(
                        'Số lượng: ${item['quantity']} | Giá: ${item['price']}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showEditDialog(item),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteProduct(item['id']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.orange,
                onPressed: _showAddDialog,
                child: const Icon(Icons.add),
              ),
            );
          },
        );
      },
    );
  }
}
