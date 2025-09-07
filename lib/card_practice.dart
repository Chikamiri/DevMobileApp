import 'package:flutter/material.dart';

class CardLearn extends StatelessWidget {
  const CardLearn({super.key});

  Widget buildCard(String text1, String text2, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.8),
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  Text(
                    text2,
                    style: const TextStyle(color: Colors.grey, fontSize: 24),
                  ),
                ],
              ),
            ),
            Expanded(flex: 1, child: Icon(icon, size: 63)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: Column(
          children: [
            buildCard(
              "Electric bill",
              "Pay electric bill this month",
              Icons.lightbulb_outline,
            ),
            buildCard(
              "Water bill",
              "Pay water bill this month",
              Icons.water_drop,
            ),
            buildCard("Mobile bill", "Pay mobile bill this month", Icons.phone),
            buildCard(
              "Internet bill",
              "Pay internet bill this month",
              Icons.wifi,
            ),
          ],
        ),
      ),
    );
  }
}
