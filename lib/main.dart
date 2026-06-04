import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(        // ← pas de const ici
      title: 'Tasky',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),   // ← pas de const ici non plus
    );
  }
}