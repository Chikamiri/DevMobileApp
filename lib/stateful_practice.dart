import 'package:flutter/material.dart';

class Bank extends StatefulWidget {
  const Bank({super.key});

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  int _selectedIndex = 0;
  String _currency = "USD";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages() => [
    _homepage(
      currency: _currency,
      onCurrencyChanged: (v) => setState(() => _currency = v),
    ),
    const Center(child: Text("Pie Chart")),
    const Center(child: Text("QR Code")),
    const Center(child: Text("Chat")),
    const Center(child: Text("User")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E1E1),
      body: _pages()[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        notchMargin: 0,
        color: Colors.white,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              Expanded(child: _navIcon(Icons.home, 0)),
              Expanded(child: _navIcon(Icons.pie_chart, 1)),

              //QR
              Container(
                width: 76,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF005EFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  onTap: () => _onItemTapped(2),
                  child: const Icon(
                    Icons.qr_code,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),

              Expanded(child: _navIcon(Icons.chat_bubble_rounded, 3)),
              Expanded(child: _navIcon(Icons.person, 4)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon, int index) {
    return IconButton(
      icon: Icon(icon),
      color: _selectedIndex == index ? const Color(0xFF005EFF) : Colors.grey,
      onPressed: () => _onItemTapped(index),
    );
  }
}

Widget _homepage({
  required String currency,
  required ValueChanged<String> onCurrencyChanged,
}) {
  String balance;
  switch (currency) {
    case "USD":
      balance = "\$20,000";
      break;
    case "RD":
      balance = "RD500,000,000";
      break;
    case "EUR":
      balance = "€18,000";
      break;
    default:
      balance = "\$0";
  }

  return SingleChildScrollView(
    child: Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Color(0xFF005EFF)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.emoji_events,
                          color: Colors.white,
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search "Payments"',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            filled: true,
                            fillColor: Colors.white.withValues(alpha: 0.2),
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton<String>(
                          isDense: true,
                          alignment: Alignment.center,
                          value: currency,
                          dropdownColor: Colors.blue,
                          underline: const SizedBox(),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          style: const TextStyle(color: Colors.white),
                          items: const [
                            DropdownMenuItem(
                              value: "USD",
                              child: Row(
                                children: [
                                  Text("🇺🇸 "),
                                  SizedBox(width: 4),
                                  Text("US Dollar"),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: "RD",
                              child: Row(
                                children: [
                                  Text("🇻🇳 "),
                                  SizedBox(width: 4),
                                  Text("RaumaDong"),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: "EUR",
                              child: Row(
                                children: [
                                  Text("🇪🇺 "),
                                  SizedBox(width: 4),
                                  Text("Euro"),
                                ],
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) onCurrencyChanged(value);
                          },
                        ),
                        const SizedBox(height: 2),
                        Text(
                          balance,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Available Balance',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFF005EFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Color(0xFFFDFDFD)),
                            ),
                          ),
                          child: const Text("Add Money"),
                        ),
                        const SizedBox(height: 70),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -40,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _ActionButton(
                      icon: Icons.send,
                      label: "Send",
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: 40,
                      child: VerticalDivider(
                        color: Colors.black26,
                        thickness: 1,
                        width: 10,
                      ),
                    ),
                    _ActionButton(
                      icon: Icons.request_page,
                      label: "Request",
                      color: Colors.orange,
                    ),
                    SizedBox(
                      height: 40,
                      child: VerticalDivider(
                        color: Colors.black26,
                        thickness: 1,
                        width: 10,
                      ),
                    ),
                    _ActionButton(
                      icon: Icons.account_balance,
                      label: "Bank",
                      color: Colors.amber,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Transaction",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _transactionItem(
                Icons.credit_card,
                "Spending",
                "-\$500",
                Colors.red,
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.keyboard_arrow_right),
                ),
              ),
              Divider(color: Colors.grey.withValues(alpha: 0.3)),
              _transactionItem(
                Icons.monetization_on,
                "Income",
                "\$3000",
                Colors.green,
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.keyboard_arrow_right),
                ),
              ),
              Divider(color: Colors.grey.withValues(alpha: 0.3)),
              _transactionItem(
                Icons.receipt_long,
                "Bills",
                "-\$800",
                Colors.red,
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.keyboard_arrow_right),
                ),
              ),
              Divider(color: Colors.grey.withValues(alpha: 0.3)),
              _transactionItem(
                Icons.savings,
                "Savings",
                "\$1000",
                Colors.orange,
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

Widget _transactionItem(
  IconData icon,
  String title,
  String amount,
  Color color,
  IconButton iconButton,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              amount,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            iconButton,
          ],
        ),
      ],
    ),
  );
}
