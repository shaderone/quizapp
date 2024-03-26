import 'package:flutter/material.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: getGradient()),
        child: SafeArea(
          child: Image.asset(
            "assets/images/app_splash_logo.png",
            width: 175,
            height: 175,
          ),
        ),
      ),
    );
  }
}
