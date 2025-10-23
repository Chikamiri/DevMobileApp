import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../internal/data_provider.dart';

class ExportsScreen extends StatefulWidget {
  const ExportsScreen({super.key});

  @override
  State<ExportsScreen> createState() => _ExportsScreenState();
}

class _ExportsScreenState extends State<ExportsScreen> {
  List<Map<String, dynamic>> exports = [];
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> customers = [];

  Future<void> _loadData(BuildContext context) async {
    final db = context.read<DataProvider>().db;
    exports = await db.getExports();
    products = await db.getProducts();
    customers = await db.getCustomers();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData(context));
  }

  void _showAddExportDialog(BuildContext context) {
    int? selectedCustomer;
    int? selectedProduct;
    final qtyCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('Thêm phiếu xuất hàng'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(labelText: 'Khách hàng'),
                  value: selectedCustomer,
                  items: customers.map((c) {
                    return DropdownMenuItem<int>(
                      value: c['id'] as int,
                      child: Text(c['name']),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => selectedCustomer = val),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(labelText: 'Sản phẩm'),
                  value: selectedProduct,
                  items: products.map((p) {
                    return DropdownMenuItem<int>(
                      value: p['id'] as int,
                      child: Text(p['name']),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => selectedProduct = val),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: qtyCtrl,
                  decoration: const InputDecoration(labelText: 'Số lượng xuất'),
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
                if (selectedCustomer == null ||
                    selectedProduct == null ||
                    qty <= 0) {
                  return;
                }

                final db = context.read<DataProvider>().db;
                await db.insertExport({
                  'productId': selectedProduct,
                  'customerId': selectedCustomer,
                  'quantity': qty,
                  'date': DateTime.now().toIso8601String(),
                });

                if (mounted) {
                  Navigator.pop(ctx);
                  await _loadData(context);
                  context.read<DataProvider>().refreshAll();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã xuất hàng thành công')),
                  );
                }
              },
              child: const Text('Lưu'),
            ),
          ],
        ),
      ),
    );
  }

  String _getProductName(int id) {
    final p = products.firstWhere((e) => e['id'] == id, orElse: () => {});
    return p['name'] ?? 'Không rõ';
  }

  String _getCustomerName(int id) {
    final c = customers.firstWhere((e) => e['id'] == id, orElse: () => {});
    return c['name'] ?? 'Không rõ';
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (_) {
      return isoDate;
    }
  }

  void _showExportDetails(Map<String, dynamic> exp) {
    final productName = _getProductName(exp['productId']);
    final customerName = _getCustomerName(exp['customerId']);
    final dateFormatted = _formatDate(exp['date']);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Chi tiết phiếu xuất'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sản phẩm: $productName'),
            Text('Khách hàng: $customerName'),
            Text('Số lượng: ${exp['quantity']}'),
            Text('Ngày xuất: $dateFormatted'),
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

  Widget _buildExportItem(Map<String, dynamic> exp) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.local_shipping, color: Colors.orange),
        title: Text(
          '${_getProductName(exp['productId'])} (-${exp['quantity']})',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Khách hàng: ${_getCustomerName(exp['customerId'])}\n'
          'Ngày: ${_formatDate(exp['date'])}',
        ),
        onTap: () => _showExportDetails(exp),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _loadData(context),
        child: exports.isEmpty
            ? const Center(child: Text('Chưa có phiếu xuất hàng nào'))
            : ListView.builder(
                itemCount: exports.length,
                itemBuilder: (context, i) => _buildExportItem(exports[i]),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddExportDialog(context),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
