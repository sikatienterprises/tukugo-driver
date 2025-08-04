import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tukugo/auth/vehicle_selection_page.dart';
import 'package:tukugo/screen/drawer/aboutUs.dart';
import 'package:tukugo/screen/drawer/changeLanguage.dart';
import 'package:tukugo/screen/drawer/contactUs.dart';
import 'package:tukugo/screen/drawer/globals.dart';
import 'package:tukugo/screen/drawer/wallet.dart';
import 'package:tukugo/screen/drawer/change-password.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String currentFlagPath = Globals.selectedFlagPath;

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
                  Icons.card_giftcard_outlined,
                  'Complete Profile',
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) => VehicleSelectionPage()),
                    );
                  },
                ),
                _buildMenuItem(
                  Icons.account_balance_wallet_outlined,
                  'Wallet',
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (context) => MyWallet()),
                    );
                  },
                ),
                _buildMenuItem(Icons.build_outlined, 'Mechanic'),
                _buildMenuItem(
                  Icons.lock_outline,
                  'Change password',
                  onTap: () => Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen()),
                  ),
                ),
                _buildMenuItem(
                  Icons.info_outline,
                  'About Us',
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (context) => const AboutUs()),
                    );
                  },
                ),
                _buildMenuItem(
                  Icons.help_outline,
                  'Help and Support',
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) => ContactUsScreen()),
                    );
                  },
                ),
                _buildMenuItem(Icons.logout, 'Logout', onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => LogoutDialog(
                      onConfirm: () {
                        // Simple logout logic
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

          // Language Section
          Container(
            padding: const EdgeInsets.only(
              left: 16,
              bottom: 32,
            ),
            child: Row(
              children: [
                Image.asset(
                  currentFlagPath,
                  height: 22,
                  width: 22,
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () async {
                    // Wait for the result from ChangeLanguagePage
                    final result =
                        await Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) => const ChangeLanguagePage()),
                    );

                    // Update the local state when returning from language selection
                    if (result != null) {
                      setState(() {
                        currentFlagPath = Globals.selectedFlagPath;
                      });
                    }
                  },
                  child: const Text(
                    'Change language',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
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

class LogoutDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // cancel
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // close dialog
            onConfirm(); // run logout action
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
