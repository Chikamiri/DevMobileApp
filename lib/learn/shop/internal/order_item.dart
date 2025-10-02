import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final String name;
  final double unitPrice;
  final double quantity;
  final IconData icon;
  final String? subtitle;

  const OrderItem({
    super.key,
    required this.name,
    required this.unitPrice,
    required this.quantity,
    required this.icon,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    int total = (unitPrice * quantity).toInt();
    String subtitleText = subtitle ?? '';
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.orange),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 4),
                  Text(
                    '${unitPrice.toInt()} x ${quantity == quantity.toInt() ? quantity.toInt() : quantity}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  if (subtitleText.isNotEmpty) ...[
                    SizedBox(height: 4),
                    Text(
                      subtitleText,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$totalđ',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Icon(Icons.notifications, color: Colors.grey, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
