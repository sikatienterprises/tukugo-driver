import 'package:flutter/material.dart';
import 'package:tukugo/screen/drawer/wallet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Logo',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 80),
            ],
          ),
          // Profile Header Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    backgroundImage: AssetImage('assets/ProfilePic.jpg'),
                  ),
                ),
                // Profile Avatar
                const SizedBox(height: 20),
                Text(
                  'Divyansh Pathak',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'sikat@gmail.com',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  Icons.account_balance_wallet_outlined,
                  'Wallet',
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (context) => const MyWallet()),
                    );
                  },
                ),
                _buildMenuItem(Icons.build_outlined, 'Mechanic'),
                _buildMenuItem(Icons.chat_bubble_outline, 'Complain'),
                _buildMenuItem(Icons.card_giftcard_outlined, 'Offers/Referral'),
                _buildMenuItem(Icons.lock_outline, 'Change password'),
                _buildMenuItem(Icons.info_outline, 'About Us'),
                _buildMenuItem(Icons.help_outline, 'Help and Support'),
                _buildMenuItem(Icons.logout, 'Logout'),
              ],
            ),
          ),

          // Language Section
          Container(
            padding: const EdgeInsets.only(
              bottom: 64,
              left: 16,
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/flags/india.png',
                  height: 22,
                  width: 22,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Change language',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
