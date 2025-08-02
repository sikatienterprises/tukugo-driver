import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopShape extends StatelessWidget {
  const TopShape({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 140,
      child: SvgPicture.asset(
        'assets/top_curve.svg',
        fit: BoxFit.cover,
      ),
    );
  }
}
