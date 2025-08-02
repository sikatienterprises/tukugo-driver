import 'package:flutter/material.dart';

class CustomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 391;
    final double yScaling = size.height / 142;
    path.lineTo(391.537 * xScaling, 0.927246 * yScaling);
    path.cubicTo(
      391.537 * xScaling, 0.927246 * yScaling,
      -9.96338 * xScaling, -3.57275 * yScaling,
      -9.96338 * xScaling, -3.57275 * yScaling,
    );
    path.cubicTo(
      -9.96338 * xScaling, -3.57275 * yScaling,
      -5.96338 * xScaling, 126.927 * yScaling,
      -5.96338 * xScaling, 126.927 * yScaling,
    );
    path.cubicTo(
      -5.96338 * xScaling, 126.927 * yScaling,
      43.5366 * xScaling, 171.134 * yScaling,
      89.5366 * xScaling, 103.427 * yScaling,
    );
    path.cubicTo(
      135.537 * xScaling, 35.7202 * yScaling,
      251.037 * xScaling, 29.7454 * yScaling,
      256.537 * xScaling, 105.427 * yScaling,
    );
    path.cubicTo(
      259.717 * xScaling, 149.188 * yScaling,
      322.191 * xScaling, 118.968 * yScaling,
      356.037 * xScaling, 79.9272 * yScaling,
    );
    path.cubicTo(
      380.726 * xScaling, 51.4486 * yScaling,
      391.537 * xScaling, 0.927246 * yScaling,
      391.537 * xScaling, 0.927246 * yScaling,
    );
    path.cubicTo(
      391.537 * xScaling, 0.927246 * yScaling,
      391.537 * xScaling, 0.927246 * yScaling,
      391.537 * xScaling, 0.927246 * yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
