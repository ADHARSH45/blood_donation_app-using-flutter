import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 255, 255, 255), // Background color of the splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/logo.png', // Replace with your logo path
              width: 100, // Adjust size as needed
              height: 100,
            ),
            SizedBox(height: 20), // Spacing between logo and title
            // Title
            Text(
              'DONATE BLOOD...',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 0, 0), // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
