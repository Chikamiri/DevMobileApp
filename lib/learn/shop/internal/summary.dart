import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        border: Border(top: BorderSide(color: Colors.grey)),
      ),
      child: Column(
        children: [
          SummaryRow(label: 'Tổng thành tiền', value: '14.1', isBoldText: true),
          SummaryRow(label: 'Tổng chiết khấu', value: '-24,800đ'),
          SummaryRow(label: 'VAT (%)', value: '0đ'),
          Divider(),
          SummaryRow(
            label: 'Khách phải trả',
            value: '223,200đ',
            isBoldText: true,
            isBoldValue: true,
          ),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBoldText;
  final bool isBoldValue;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isBoldText = false,
    this.isBoldValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBoldText ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBoldValue ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
