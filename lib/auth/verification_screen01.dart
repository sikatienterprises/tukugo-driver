import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tukugo/auth/aadhar.dart';
import 'package:tukugo/auth/driving_license.dart';
import 'package:tukugo/auth/vehicle_rc.dart';
import 'package:tukugo/routes/route_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VerificationScreen01(),
    );
  }
}

class VerificationScreen01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.help_outline, color: Colors.black, size: 20),
                SizedBox(width: 4),
                Text(
                  'Help',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Blue info container
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF64B5F6),
                borderRadius: BorderRadius.only(
                    // bottomLeft: Radius.circular(16),
                    // bottomRight: Radius.circular(16),
                    ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please complete all the',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'steps to activate your',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.shield_outlined,
                    color: Colors.white,
                    size: 48,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Verification cards
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    VerificationCard(
                      title: 'Drivers License',
                      subtitle: 'Under verification',
                      icon: Icons.warning_rounded,
                      iconColor: Colors.orange,
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => LicenseUploadPage()),
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    VerificationCard(
                      title: 'Profile Info',
                      subtitle: 'Under verification',
                      icon: Icons.warning_rounded,
                      iconColor: Colors.orange,
                      onTap: () {
                        // Navigate to profile info
                      },
                    ),
                    SizedBox(height: 12),
                    VerificationCard(
                      title: 'Vehicle RC',
                      subtitle: 'Under verification',
                      icon: Icons.warning_rounded,
                      iconColor: Colors.orange,
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(builder: (context) => VehicleRc()),
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    VerificationCard(
                      title: 'Aadhaar / Pan card',
                      subtitle: 'Under verification',
                      icon: Icons.warning_rounded,
                      iconColor: Colors.orange,
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => AadhaarUploadPage()),
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    VerificationCard(
                      title: 'Payment (Optional)',
                      subtitle: '',
                      icon: Icons.arrow_forward_ios,
                      iconColor: Colors.grey,
                      onTap: () {
                        // Navigate to payment
                      },
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
}

class VerificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const VerificationCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue[600],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
