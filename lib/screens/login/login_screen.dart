import 'package:flutter/material.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String loginRouteName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: getGradient()),
      ),
    );
  }
}
