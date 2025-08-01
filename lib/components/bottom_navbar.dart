import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tukugo/screen/drawer/profile_drawer.dart';
import 'package:tukugo/screen/history_screen.dart';
import 'package:tukugo/screen/home_screen.dart';
import 'package:tukugo/screen/notification_screen.dart';

class BottomNavPainter extends CustomPainter {
  final int selectedIndex;

  BottomNavPainter({required this.selectedIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E1E1E)
      ..style = PaintingStyle.fill;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Layout extends StatefulWidget {
  final Widget child;
  const Layout({super.key, required this.child});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentPage = 0;
  List<Widget> pages = const [
    HomeScreen(),
    PaymentHistory(),
    Notifications(),
    ProfileScreen(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child, // ✅ Shows the current page inside Shell
      bottomNavigationBar: Container(
        height: 80,
        child: Stack(
          children: [
            // Background with arc cutout for selected item
            Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(18, 18, 18, 1),
              ),
              child: selectedIndex >= 0
                  ? CustomPaint(
                      painter: BottomNavPainter(selectedIndex: selectedIndex),
                      size: Size(MediaQuery.of(context).size.width, 80),
                    )
                  : null,
            ),
            // Navigation items
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Home
                  _buildNavItem(
                    icon: Icons.home_rounded,
                    index: 0,
                    selectedIndex: selectedIndex,
                    onTap: () {
                      selectedIndex = 0;
                      context.go('/home');
                    },
                  ),
                  // Payment/Pie Chart

                  // History
                  _buildNavItem(
                    icon: Icons.history,
                    index: 2,
                    selectedIndex: selectedIndex,
                    onTap: () {
                      selectedIndex = 2;
                      context.go('/ride-history');
                    },
                  ),
                  // Notifications
                  _buildNavItem(
                    icon: Icons.notifications_none_rounded,
                    index: 3,
                    selectedIndex: selectedIndex,
                    onTap: () {
                      selectedIndex = 3;
                      context.go('/notifications');
                    },
                  ),
                  // _buildNavItem(
                  //   icon: Icons.pie_chart_outline_rounded,
                  //   index: 1,
                  //   selectedIndex: selectedIndex,
                  //   onTap: () {
                  //     selectedIndex = 1;
                  //     context.go('/payment');
                  //   },
                  // ),
                  _buildNavItem(
                    icon: Icons.person,
                    index: 1,
                    selectedIndex: selectedIndex,
                    onTap: () {
                      selectedIndex = 1;
                      context.go('/home/profile');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required int selectedIndex,
    required VoidCallback onTap,
  }) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 80,
        height: 80,
        transform: Matrix4.translationValues(0, isSelected ? -40 : 0, 0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Bottom half ring
            if (isSelected)
              Positioned(
                bottom: 0,
                child: Container(
                  width: 80,
                  height: 40, // Half of total height
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(103, 46, 46, 46),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(40),
                    ),
                  ),
                ),
              ),

            // Main Icon Circle
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xFF2196F3) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
