import 'package:donate_blood/selectscreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SelectionScreen()),
      );
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(
          child: Text(
            'DONTAE BLOOD...',
            style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
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
