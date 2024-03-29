import 'package:get/get.dart';
import 'package:quiz_app/screens/home/home_screen.dart';
import 'package:quiz_app/screens/login/login_screen.dart';
import 'package:quiz_app/screens/onboarding/onboarding_screen.dart';
import 'package:quiz_app/screens/splash/splash_screen.dart';

import '../controllers/drawer_menu_controller.dart';
import '../controllers/question_paper/question_paper_controller.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(name: "/", page: () => const SplashScreen()),
    GetPage(
      name: OnboardingScreen.onboardingScreenRouteName,
      page: () => const OnboardingScreen(),
      binding: BindingsBuilder(() {
        //This is just to load the data in HomeScreen faster
        Get.put(QuestionPaperController());
      }),
    ),
    GetPage(
      name: HomeScreen.homeScreenRouteName,
      page: () => const HomeScreen(),
      binding: BindingsBuilder(() {
        Get.put(QuestionPaperController());
        Get.put(DrawerMenuController());
      }),
    ),
    GetPage(
      name: LoginScreen.loginRouteName,
      page: () => const LoginScreen(),
    ),
  ];
}
