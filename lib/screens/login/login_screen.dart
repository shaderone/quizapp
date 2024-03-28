import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common/common_widgets.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';
import 'package:quiz_app/controllers/auth_controller.dart';
import 'package:quiz_app/screens/login/file_paths.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  static const String loginRouteName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: getGradient()),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage(FilePaths.mainIconPath),
                width: 200,
                height: 200,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Text(
                  "Test your knowledge with our trivia app! Dive into thousands of questions across diverse topics. Compete with friends, track your scores, and rise to the top as the ultimate quiz champion!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              MainButtonWidget(
                onTap: () async {
                  await controller.signInWithGoogle();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(FilePaths.googleIconPath),
                      Gap.horizontal(15),
                      const Text("Sign in with google"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
