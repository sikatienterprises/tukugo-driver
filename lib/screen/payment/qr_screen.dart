import 'package:flutter/material.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(175, 175, 175, 0.1),
        elevation: 0,
        title: const Text(
          'QR Code',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
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
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            Center(
              child: Column(
                spacing: 12,
                children: [
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Image.asset('assets/QR.png'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(342, 10),
                      backgroundColor: Color.fromRGBO(217, 217, 217, 0.4),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
