import 'package:get/get.dart';
import 'package:quiz_app/screens/onboarding_screen.dart';
import 'package:quiz_app/screens/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(name: "/", page: () => const SplashScreen()),
    GetPage(name: "/onboarding", page: () => const OnboardingScreen()),
  ];
}
