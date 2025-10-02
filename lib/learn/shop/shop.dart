import 'package:flutter/material.dart';
import 'internal/order_item.dart';
import 'internal/summary.dart';
import 'internal/customer_info.dart';
import 'internal/action_button.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
        title: Text('Đơn hàng'),
        actions: [
          IconButton(icon: Icon(Icons.menu_book), onPressed: () {}),
          IconButton(icon: Icon(Icons.print), onPressed: () {}),
          IconButton(icon: Icon(Icons.phone), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomerInfoSection(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bàn số 1', style: TextStyle(fontWeight: FontWeight.bold)),
                Row(children: [Text('Vị trí A'), Icon(Icons.arrow_drop_down)]),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  OrderItem(
                    name: 'Sữa cacao',
                    unitPrice: 18000,
                    quantity: 1,
                    icon: Icons.local_drink,
                  ),
                  OrderItem(
                    name: 'Sữa nóng',
                    unitPrice: 15000,
                    quantity: 6,
                    icon: Icons.local_cafe,
                  ),
                  OrderItem(
                    name: 'Pepsi lon',
                    unitPrice: 15000,
                    quantity: 4,
                    icon: Icons.local_drink,
                  ),
                  OrderItem(
                    name: 'Tiền giờ',
                    unitPrice: 200000,
                    quantity: 0.1,
                    icon: Icons.access_time,
                    subtitle: '12/03 15:15 -> 12/03 15:20 (6 phút)',
                  ),
                  OrderItem(
                    name: 'Dưa hấu ép',
                    unitPrice: 20000,
                    quantity: 3,
                    icon: Icons.local_drink,
                  ),
                ],
              ),
            ),
            OrderSummary(),
          ],
        ),
      ),
      bottomNavigationBar: ActionButtons(),
    );
  }
}
