import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common/widgets.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(gradient: getGradient()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                size: 32,
              ),
              Gap.vertical(20),
              const Text(
                "Get ready to challenge your knowledge! Our quiz app offers diverse topics, friendly competition, and global leaderboards. Learn, play, and conquer!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ksurfaceTextColor,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.offAllNamed("/home"),
        child: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
