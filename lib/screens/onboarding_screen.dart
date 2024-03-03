import 'package:flutter/material.dart';
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
          decoration: BoxDecoration(gradient: getGradient(context)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                size: 32,
              ),
              Gap(20),
              Text(
                "Get ready to challenge your knowledge! Our quiz app offers diverse topics, friendly competition, and global leaderboards. Learn, play, and conquer!",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
