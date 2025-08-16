import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ReportIssueScreen extends StatefulWidget {
  @override
  _ReportIssueScreenState createState() => _ReportIssueScreenState();
}


class _ReportIssueScreenState extends State<ReportIssueScreen> {
  String? selectedVehicleType;
  String? selectedBrand;
  String? selectedModel;
  String? selectedIssue;
  String description = '';
  File? _image;
  final ImagePicker _picker = ImagePicker();

  final List<VehicleType> vehicleTypes = [
    VehicleType('E-Rikshaw', Icons.electric_rickshaw),
    VehicleType('Car', Icons.directions_car),
    VehicleType('Bike', Icons.motorcycle),
    VehicleType('Auto', 'assets/auto.png', isAssetImage: true),
  ];

  final List<String> brands = [
    'Maruti Suzuki',
    'Hyundai',
    'Tata Motors',
    'Mahindra',
    'Honda',
    'Toyota',
    'Skoda',
    'Bajaj',
    'Hero MotoCorp',
    'TVS',
    'Royal Enfield',
    'Yamaha',
    'Suzuki'
  ];

  final Map<String, List<String>> modelsByBrand = {
    'Maruti Suzuki': ['Alto 800', 'Wagon R', 'Swift', 'Dzire'],
    'Hyundai': ['i10', 'i20', 'Creta', 'Verna'],
    'Tata Motors': ['Tiago', 'Nexon', 'Harrier', 'Safari'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Report an issue',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Type Selector
            Text(
              'Choose the vehicle Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            _buildDropdown(
              value: selectedVehicleType,
              hint: 'Car',
              onTap: () => _showVehicleTypeSelector(),
              showGreenBorder: true,
            ),
            
            SizedBox(height: 20),
            
            // Brand Selector
            Text(
              'Choose vehicle Brand',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            _buildDropdown(
              value: selectedBrand,
              hint: 'Maruti Suzuki',
              onTap: () => _showBrandSelector(),
              showGreenBorder: true,
            ),
            
            SizedBox(height: 20),
            
            // Model Input
            Text(
              'Enter vehicle Model',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF00A83F), width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Alto 800',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                ),
                onChanged: (value) => setState(() => selectedModel = value),
              ),
            ),
            
            SizedBox(height: 20),
            
            // Issue Type Input
            Text(
              'Enter Issue Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,

              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF00A83F), width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Engine not starting',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                ),
                onChanged: (value) => setState(() => selectedIssue = value),
              ),
            ),
            
            SizedBox(height: 20),
            
            // Description
            Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF00A83F), width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Write your description here',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
                onChanged: (value) => setState(() => description = value),
              ),
            ),
            
            SizedBox(height: 20),
            
            // Image Upload
            Text(
              'Upload Problem Image',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade50,
                ),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            size: 40,
                            color: Colors.grey.shade600,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Upload Image',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            
            Spacer(),
            
            // Submit Button
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle find mechanic action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00A83F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Find Mechanic',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    String? value,
    required String hint,
    required VoidCallback onTap,
    bool showGreenBorder = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: showGreenBorder ? Color(0xFF00A83F) : Colors.grey.shade300,
            width: showGreenBorder ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value ?? hint,
                style: TextStyle(
                  fontSize: 16,
                  color: value != null ? Colors.black : Colors.grey.shade600,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }

  void _showVehicleTypeSelector() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VehicleTypeSelectorScreen(
          vehicleTypes: vehicleTypes,
          selectedType: selectedVehicleType,
          onTypeSelected: (type) {
            setState(() => selectedVehicleType = type);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showBrandSelector() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BrandSelectorScreen(
          brands: brands,
          selectedBrand: selectedBrand,
          onBrandSelected: (brand) {
            setState(() {
              selectedBrand = brand;
              selectedModel = null; // Reset model when brand changes
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}

class VehicleType {
  final String name;
  final dynamic icon;
  final bool isAssetImage;
  
  VehicleType(this.name, this.icon, {this.isAssetImage = false});
}

class VehicleTypeSelectorScreen extends StatelessWidget {
  final List<VehicleType> vehicleTypes;
  final String? selectedType;
  final Function(String) onTypeSelected;

  VehicleTypeSelectorScreen({
    required this.vehicleTypes,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Report an issue',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose the vehicle Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: vehicleTypes.length,
                itemBuilder: (context, index) {
                  final type = vehicleTypes[index];
                  final isSelected = selectedType == type.name;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFFE4FFE4) : Colors.white,
                      border: Border.all(
                        color: isSelected ? Color(0xFF00A83F) : Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: type.isAssetImage
                        ? Image.asset(
                            type.icon,
                            width: 28,
                            height: 28,
                          )
                        : Icon(
                            type.icon,
                            color: Colors.black87,
                            size: 28,
                          ),
                      title: Text(
                        type.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: Radio<String>(
                        value: type.name,
                        groupValue: selectedType,
                        onChanged: (value) => onTypeSelected(value!),
                        activeColor: Color(0xFF00A83F),
                      ),
                      onTap: () => onTypeSelected(type.name),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00A83F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Find Mechanic',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class BrandSelectorScreen extends StatelessWidget {
  final List<String> brands;
  final String? selectedBrand;
  final Function(String) onBrandSelected;

  BrandSelectorScreen({
    required this.brands,
    required this.selectedBrand,
    required this.onBrandSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Report an issue',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose the vehicle Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            _buildDropdown('Car'),
            SizedBox(height: 20),
            Text(
              'Choose vehicle Brand',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: brands.length,
                itemBuilder: (context, index) {
                  final brand = brands[index];
                  final isSelected = selectedBrand == brand;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFFE4FFE4) : Colors.white,
                      border: Border.all(
                        color: isSelected ? Color(0xFF00A83F) : Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        brand,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: Radio<String>(
                        value: brand,
                        groupValue: selectedBrand,
                        onChanged: (value) => onBrandSelected(value!),
                        activeColor: Color(0xFF00A83F),
                      ),
                      onTap: () => onBrandSelected(brand),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00A83F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Find Mechanic',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String text) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
        ],
      ),
    );
  }
}