import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Main Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 10),

                    // Header with back arrow, profile, and buttons
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3), // thickness of the border
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blue, // border color
                              width: 2.0, // border width
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage:
                                AssetImage('assets/ProfilePic.jpg'),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Divyansh',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => context.go('/auth/drawer/addmoney'),
                          child: Container(
                            width: 168,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.blue, // Blue color border
                                width: 2, // 2 pixels wide
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Add Money',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),

                    // Balance Cards
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 145,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(228, 242, 255, 1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.blue, // Blue color border
                                width: 1, // 2 pixels wide
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '₹500',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Available Balance',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 145,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(228, 242, 255, 1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.blue, // Blue color border
                                width: 1, // 2 pixels wide
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '₹200',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Total Expense',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),

                    // Transactions Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transactions',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.go(
                            '/auth/drawer/transactions',
                          ),
                          child: Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4A90E2),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Transaction List
                    Expanded(
                      child: ListView(
                        children: [
                          _buildTransactionItem(
                            'Sanjana',
                            'Today at 09:28 am',
                            '-₹270.00',
                            Color(0xFFFFE5E5),
                            Color(0xFFFF6B6B),
                            'S',
                          ),
                          _buildTransactionItem(
                            'Priyam',
                            'Today at 09:28 am',
                            '+₹270.00',
                            Color(0xFFE8F5E8),
                            Color(0xFF4CAF50),
                            'P',
                          ),
                          _buildTransactionItem(
                            'Sanjana',
                            'Today at 09:28 am',
                            '-₹270.00',
                            Color(0xFFFFE5E5),
                            Color(0xFFFF6B6B),
                            'S',
                          ),
                          _buildTransactionItem(
                            'Priyam',
                            'Today at 09:28 am',
                            '+₹270.00',
                            Color(0xFFE8F5E8),
                            Color(0xFF4CAF50),
                            'P',
                          ),
                          _buildTransactionItem(
                            'Sanjana',
                            'Today at 09:28 am',
                            '-₹270.00',
                            Color(0xFFFFE5E5),
                            Color(0xFFFF6B6B),
                            'S',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(
    String name,
    String time,
    String amount,
    Color circleBackgroundColor,
    Color circleTextColor,
    String letter,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: circleBackgroundColor,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Center(
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: circleTextColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
