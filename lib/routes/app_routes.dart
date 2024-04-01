import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_paper/questions_controller.dart';
import 'package:quiz_app/screens/home/home_screen.dart';
import 'package:quiz_app/screens/login/login_screen.dart';
import 'package:quiz_app/screens/onboarding/onboarding_screen.dart';
import 'package:quiz_app/screens/question/question_screen.dart';
import 'package:quiz_app/screens/question/test_overview_screen.dart';
import 'package:quiz_app/screens/splash/splash_screen.dart';

import '../controllers/drawer_menu_controller.dart';
import '../controllers/question_paper/question_paper_controller.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(name: "/", page: () => const SplashScreen()),
    GetPage(
      name: OnboardingScreen.onboardingScreenRouteName,
      page: () => const OnboardingScreen(),
      binding: BindingsBuilder.put(() => QuestionPaperController()),
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
    GetPage(
      name: QuestionScreen.questionScreenRouteName,
      page: () => const QuestionScreen(),
      // ? When Using GetBuilder with id, the controller should be specifically mentiond on put().
      binding: BindingsBuilder(() => Get.put<QuestionsController>(QuestionsController())),
    ),
    GetPage(
      name: TestOverviewScreen.testOverviewScreenRouteName,
      page: () => const TestOverviewScreen(),
      //binding: BindingsBuilder.put(() => QuestionsController()),
    ),
  ];
}
