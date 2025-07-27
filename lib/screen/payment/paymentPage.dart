import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:tukugo/screen/payment/qr_screen.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(175, 175, 175, 0.1),
        elevation: 0,
        title: Text(
          'Payment',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.help_outline,
              color: Color.fromRGBO(0, 0, 0, 0.5),
              size: 25,
            ),
            label: const Text(
              'Help',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(44),
              child: Column(
                children: [
                  // Charge Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.normal,
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 44.0, right: 44, top: 10),
                      child: Column(
                        children: [
                          const Text(
                            'Total Charge',
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '₹100.0',
                            style: TextStyle(
                              color: Color.fromRGBO(82, 171, 18, 1),
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'For your final earning, click ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 0.4),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Handle click action
                                  },
                                  child: const Text(
                                    'here',
                                    style: TextStyle(
                                      color: Color.fromRGBO(253, 184, 36, 1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Action Buttons
                  Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) => const QrScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2196F3),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Show QR',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle Collect Cash action
                              _showCollectCashBottomSheet(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2196F3),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Collect Cash',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Image.asset(
                      'assets/payment.png',
                    ),
                  ]),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showCollectCashBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: Navigator.of(context, rootNavigator: true).context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 21,
          children: [
            Column(
              spacing: 22,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(82, 171, 18, 1), // Green background
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.currency_rupee_outlined,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
                const Text(
                  'Collect ₹100.0 Cash',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(82, 171, 18, 1),
                  ),
                ),
              ],
            ),
            Column(
              spacing: 12,
              children: [
                const Text(
                  'Did you receive cash payment from the customer?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromRGBO(10, 132, 255, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'If yes, confirm by selecting ',
                      style: TextStyle(
                          fontSize: 16, color: Color.fromRGBO(0, 0, 0, 0.6)),
                    ),
                    const Text(
                      '"Collected."',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'If no, choose ',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                          fontWeight: FontWeight.w400),
                    ),
                    const Text(
                      '"Go Back"',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                          fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      ' to cancel or retry.',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Color.fromRGBO(10, 132, 255, 1),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Go Back',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // You can add your 'collected' logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Payment marked as collected',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Color.fromRGBO(20, 145, 20, 1),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Collected',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16)
          ],
        ),
      );
    },
  );
}
