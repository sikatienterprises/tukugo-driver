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
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          titleLarge: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(0, 0, 0, 0.8),
          ),
          titleMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),

      debugShowCheckedModeBanner: false, // Hide debug banner
      title: 'Tukugo',
      routerConfig: routerContext.router,
    );
  }
}
