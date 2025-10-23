import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../internal/data_provider.dart';

class ImportsScreen extends StatefulWidget {
  const ImportsScreen({super.key});

  @override
  State<ImportsScreen> createState() => _ImportsScreenState();
}

class _ImportsScreenState extends State<ImportsScreen> {
  List<Map<String, dynamic>> imports = [];
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> suppliers = [];

  Future<void> _loadData(BuildContext context) async {
    final db = context.read<DataProvider>().db;
    imports = await db.getImports();
    products = await db.getProducts();
    suppliers = await db.getSuppliers();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData(context));
  }

  void _showAddImportDialog(BuildContext context) {
    int? selectedSupplier;
    int? selectedProduct;
    final qtyCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Thêm phiếu nhập hàng'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'Nhà cung cấp'),
                value: selectedSupplier,
                items: suppliers.map((s) {
                  return DropdownMenuItem<int>(
                    value: s['id'] as int,
                    child: Text(s['name'] ?? '-'),
                  );
                }).toList(),
                onChanged: (val) => selectedSupplier = val,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'Sản phẩm'),
                value: selectedProduct,
                items: products.map((p) {
                  return DropdownMenuItem<int>(
                    value: p['id'] as int,
                    child: Text(p['name'] ?? '-'),
                  );
                }).toList(),
                onChanged: (val) => selectedProduct = val,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: qtyCtrl,
                decoration: const InputDecoration(labelText: 'Số lượng nhập'),
                keyboardType: TextInputType.number,
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
              final qty = int.tryParse(qtyCtrl.text) ?? 0;
              if (selectedSupplier == null ||
                  selectedProduct == null ||
                  qty <= 0) {
                return;
              }

              final db = context.read<DataProvider>().db;
              await db.insertImport({
                'productId': selectedProduct,
                'supplierId': selectedSupplier,
                'quantity': qty,
                'date': DateTime.now().toIso8601String(),
              });

              if (mounted) {
                Navigator.pop(ctx);
                await _loadData(context);
                context.read<DataProvider>().refreshAll();
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

  String _getProductName(int id) {
    final p = products.firstWhere((e) => e['id'] == id, orElse: () => {});
    return (p['name'] != null) ? p['name'].toString() : 'Không rõ';
  }

  String _getSupplierName(int id) {
    final s = suppliers.firstWhere((e) => e['id'] == id, orElse: () => {});
    return (s['name'] != null) ? s['name'].toString() : 'Không rõ';
  }

  String _formatDate(String? isoDate) {
    if (isoDate == null) return '';
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (_) {
      return isoDate;
    }
  }

  void _showImportDetails(Map<String, dynamic> imp) {
    final productName = _getProductName(imp['productId']);
    final supplierName = _getSupplierName(imp['supplierId']);
    final dateFormatted = _formatDate(imp['date'] as String?);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Chi tiết phiếu nhập'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sản phẩm: $productName'),
            Text('Nhà cung cấp: $supplierName'),
            Text('Số lượng: ${imp['quantity']}'),
            Text('Ngày nhập: $dateFormatted'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  Widget _buildImportItem(Map<String, dynamic> imp) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.add_box, color: Colors.orange),
        title: Text(
          '${_getProductName(imp['productId'])} (+${imp['quantity']})',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Nhà cung cấp: ${_getSupplierName(imp['supplierId'])}\n'
          'Ngày: ${_formatDate(imp['date'] as String?)}',
        ),
        onTap: () => _showImportDetails(imp),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _loadData(context),
        child: imports.isEmpty
            ? const Center(child: Text('Chưa có phiếu nhập hàng nào'))
            : ListView.builder(
                itemCount: imports.length,
                itemBuilder: (context, i) => _buildImportItem(imports[i]),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddImportDialog(context),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
