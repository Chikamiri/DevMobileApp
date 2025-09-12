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

  // danh sách trang dựa trên state
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
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: const Color(0xFF005EFF),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Icon(Icons.home),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 5, right: 30),
              child: Icon(Icons.pie_chart),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 5, left: 30),
              child: Icon(Icons.chat_bubble),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Icon(Icons.person),
            ),
            label: '',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF005EFF),
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
        child: const Icon(Icons.qr_code, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Color(0xFF005EFF)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // search
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
                            fillColor: Colors.white.withOpacity(0.2),
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

                  // balance
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

            // Action buttons
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _ActionButton(
                      icon: Icons.send,
                      label: "Send",
                      color: Colors.blue,
                    ),
                    _ActionButton(
                      icon: Icons.request_page,
                      label: "Request",
                      color: Colors.orange,
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

        const SizedBox(height: 60), // để transaction không bị đè
        // Transaction
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Transaction",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 8),
        _transactionItem(Icons.credit_card, "Spending", "-\$500", Colors.red),
        _transactionItem(
          Icons.monetization_on,
          "Income",
          "\$3000",
          Colors.green,
        ),
        _transactionItem(Icons.receipt_long, "Bills", "-\$800", Colors.red),
        _transactionItem(Icons.savings, "Savings", "\$1000", Colors.orange),
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
          backgroundColor: color.withOpacity(0.2),
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
) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: color.withOpacity(0.2),
      child: Icon(icon, color: color),
    ),
    title: Text(title),
    trailing: Text(
      amount,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    ),
  );
}
