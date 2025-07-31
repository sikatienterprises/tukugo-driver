import 'package:flutter/material.dart';

class AppStyles {  // Colors
  static const Color backgroundColor = Color(0xFFFDF3F1);
  static const Color orange = Color(0xFFFBB03B);
  static const Color blueGradientStart = Color(0xFF2196F3);
  static const Color blueGradientEnd = Color(0xFF0D47A1);
  static const Color greenBorder = Color(0xFF7CB342);
  static const Color primaryColor = Color(0xFF2196F3); // Adding primary color
  
  // Text Styles
  static TextStyle headingStyle = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle subHeading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.grey.shade600,
  );
  
  static const TextStyle labelStyle = TextStyle(
    color: orange,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  // Decorations
  static InputDecoration textFieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: labelStyle,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: greenBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: greenBorder, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  static BoxDecoration gradientButtonDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [blueGradientStart, blueGradientEnd],
    ),
    borderRadius: BorderRadius.circular(10),
  );
}
