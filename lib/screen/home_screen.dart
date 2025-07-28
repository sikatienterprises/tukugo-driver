import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:tukugo/routes/route_constants.dart';
import 'package:tukugo/screen/drawer/profile_drawer.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOnDuty = false;
  int selectedBottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(76), // Increased height
        child: SafeArea(
          child: Container(
            color: Colors.white,
            padding:
                const EdgeInsets.only(left: 56, top: 4, bottom: 4, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ride",
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.8),
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            height: 0.8 // Reduced line height
                            ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Safe ",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              height: 1.1, // Reduced line height
                            ),
                          ),
                          Text(
                            "and ",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.8),
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              // Reduced line height
                            ),
                          ),
                          Text(
                            "Secure",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              height: 1.1, // Reduced line height
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Builder(
                  builder: (context) => InkWell(
                    child: Icon(Icons.menu, color: Colors.black, size: 30),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Blue header section
          Container(
            width: double.infinity,
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Today's Returns",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  "₹0",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // OFF DUTY toggle section
          Expanded(
            child: Stack(
              children: [
                // Show map if ON DUTY, else show normal content
                isOnDuty
                    ? FlutterMap(
                        options: MapOptions(
                          center: LatLng(28.6139, 77.2090),
                          zoom: 13.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c'],
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 80),
                        child: Column(
                          children: [
                            Image.network(
                              'https://i.ibb.co/C33QCK2M/7610-removebg-preview.png',
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Good morning!",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Time to kick off the day and start Earning.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                Positioned(
                  top: 20,
                  left: MediaQuery.of(context).size.width / 3.2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isOnDuty = !isOnDuty;
                            });
                          },
                          child: Container(
                            width: 44,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: isOnDuty
                                  ? Colors.green
                                  : Colors.grey.shade400,
                            ),
                            child: AnimatedAlign(
                              duration: const Duration(milliseconds: 200),
                              alignment: isOnDuty
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                width: 20,
                                height: 40,
                                margin: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isOnDuty ? "ON DUTY " : "OFF DUTY",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom navigation
              ],
            ),
          )
        ],
      ),
    );
  }
}
