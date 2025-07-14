import 'package:flutter/material.dart';
import 'routes/route_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var routerContext = MyAppRouter();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, // Hide debug banner
      title: 'Tukugo',
      routerConfig: routerContext.router,
    );
  }
}
