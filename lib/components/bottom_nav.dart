import 'package:flutter/material.dart';
import '/screen/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int)? onTap;
  const BottomNavBar({Key? key, this.selectedIndex = 0, this.onTap}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int selectedBottomIndex;

  @override
  void initState() {
    super.initState();
    selectedBottomIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedBottomIndex = index;
    });
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
    switch (index) {
      case 0:
        // Already on home screen, no navigation needed
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HistoryScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HelpScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home, 0),
          _buildNavItem(Icons.history, 1),
          _buildNavItem(Icons.help_outline, 2),
          _buildNavItem(Icons.person_outline, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selectedBottomIndex == index ? Colors.blue : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
