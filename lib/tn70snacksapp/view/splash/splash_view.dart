import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../on_boarding/welcome_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // Always show WelcomeScreen after splash
      Get.offAll(() =>  WelcomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: screenWidth * 0.5,
          height: screenHeight * 0.25,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
