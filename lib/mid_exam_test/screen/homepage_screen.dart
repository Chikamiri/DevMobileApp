import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../internal/data_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  int totalProducts = 0;
  int totalExports = 0;
  int totalCustomers = 0;
  int totalSuppliers = 0;
  int totalQuantity = 0;
  List<Map<String, dynamic>> productList = [];

  @override
  bool get wantKeepAlive => true;

  Future<void> _loadData(BuildContext context) async {
    final db = context.read<DataProvider>().db;

    final products = await db.getProducts();
    final exports = await db.getExports();
    final customers = await db.getCustomers();
    final suppliers = await db.getSuppliers();

    // tính tổng quantity
    int totalQty = 0;
    for (final p in products) {
      totalQty += (p['quantity'] as int? ?? 0);
    }

    if (mounted) {
      setState(() {
        productList = products;
        totalProducts = products.length;
        totalExports = exports.length;
        totalCustomers = customers.length;
        totalSuppliers = suppliers.length;
        totalQuantity = totalQty;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Consumer<DataProvider>(
      builder: (context, provider, _) {
        _loadData(context); // reload khi notifyListeners()

        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () => _loadData(context),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Trang tổng quan',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 20),

                // Tổng số mặt hàng
                _buildCard(
                  icon: Icons.inventory,
                  title: 'Tổng số mặt hàng',
                  value: '$totalProducts loại',
                ),
                const SizedBox(height: 12),

                // Tổng số lượng tồn kho
                _buildCard(
                  icon: Icons.store,
                  title: 'Tổng số lượng tồn kho',
                  value: '$totalQuantity sản phẩm',
                ),
                const SizedBox(height: 12),

                // Tổng số phiếu xuất
                _buildCard(
                  icon: Icons.local_shipping,
                  title: 'Tổng số phiếu xuất',
                  value: '$totalExports phiếu',
                ),
                const SizedBox(height: 12),

                // Khách hàng & Nhà cung cấp
                _buildCard(
                  icon: Icons.people,
                  title: 'Khách hàng & Nhà cung cấp',
                  value:
                      '$totalCustomers khách hàng, $totalSuppliers nhà cung cấp',
                ),
                const SizedBox(height: 24),

                const Text(
                  'Danh sách hàng hóa',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 8),

                if (productList.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text('Chưa có sản phẩm nào trong kho'),
                    ),
                  )
                else
                  ...productList.map(
                    (p) => Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: const Icon(
                          Icons.inventory_2_outlined,
                          color: Colors.orange,
                        ),
                        title: Text(p['name']),
                        subtitle: Text(
                          'Tồn kho: ${p['quantity']} | Giá: ${p['price'] ?? 0}',
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
