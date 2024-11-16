import 'package:donate_blood/home.dart';
import 'package:donate_blood/selectscreen.dart';
import 'package:donate_blood/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donate_Blood',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 255, 0, 0)),
      home: SplashScreen(),
    );
  }
}
