import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tukugo/routes/route_constants.dart';

class VehicleSelectionPage extends StatefulWidget {
  const VehicleSelectionPage({super.key});

  @override
  State<VehicleSelectionPage> createState() => _VehicleSelectionPageState();
}

class _VehicleSelectionPageState extends State<VehicleSelectionPage> {
  String? _selectedVehicle;

  void _submitSelection() {
    if (_selectedVehicle != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You selected: $_selectedVehicle')),
      );
      GoRouter.of(context)
          .pushNamed(MyAppRouteConstants.verification_screen01RouteName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a vehicle!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const double headerHeight = 120;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // SVG header at the top
            SizedBox(
              height: headerHeight,
              width: double.infinity,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/vehicalselect.svg',
                    width: double.infinity,
                    height: headerHeight,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.help_outline, color: Colors.white),
                        SizedBox(width: 6),
                        Text('Help', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Main Page Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Which type of Vehicle do you use?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),

                    _vehicleOption('E-Rickshaw', Icons.electric_rickshaw),
                    _vehicleOption('Car', Icons.directions_car),
                    _vehicleOption('Bike', Icons.motorcycle),
                    _vehicleOption('Auto', Icons.local_taxi),

                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitSelection,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedVehicle != null
                              ? Colors.orange
                              : const Color.fromARGB(255, 233, 189, 139),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
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

  Widget _vehicleOption(String title, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: const Color.fromARGB(255, 1, 0, 5)),
        title: Text(title),
        trailing: Radio<String>(
          value: title,
          groupValue: _selectedVehicle,
          onChanged: (value) => setState(() => _selectedVehicle = value),
        ),
      ),
    );
  }
}
