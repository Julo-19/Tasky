import 'package:flutter/material.dart';
import 'package:tasky/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => OnboardingScreen()),
        );
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Image de fond
            Image.asset(
              'assets/images/bg-splash.png',
              fit: BoxFit.cover,
            ),

            // Logo au centre
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 350,
              ),
            ),

            // "Toucher pour commencer" en bas
            Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: Text(
                'Toucher pour commencer',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}