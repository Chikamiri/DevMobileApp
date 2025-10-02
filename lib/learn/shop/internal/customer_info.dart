import 'package:flutter/material.dart';

class CustomerInfoSection extends StatelessWidget {
  const CustomerInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InfoCard(icon: Icons.price_check, label: 'Giá niêm yết'),
        InfoCard(icon: Icons.person, label: 'Anh Luis Thái'),
        InfoCard(icon: Icons.add, label: 'Chọn món'),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  const InfoCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 32, color: Colors.orange),
        ),
        SizedBox(height: 4),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }
}
