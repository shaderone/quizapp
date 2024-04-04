import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerMenuController extends GetxController {
  final drawerMenuController = ZoomDrawerController();
  final Rxn<User?> user = Rxn<User?>();

  @override
  void onReady() {
    //get user from firebase
    user.value = Get.find<AuthController>().getUser();
  }

  void toggleDrawer() {
    drawerMenuController.toggle?.call();
    update();
  }

  // ** All Task for each menu item

  //* SIGNIN
  void signIn() {
    //show dialog before signing in, also notify the user.
    Get.find<AuthController>().navigateToLoginScreen();
  }

  //* SINGOUT
  void signOut() {
    Get.find<AuthController>().signOut();
    //navigate to login screen or show a snackbar.

    Get.find<AuthController>().navigateToHomeScreen();
    //Get.showSnackbar(const GetSnackBar(message: "Logged out successfully"));
  }

  //* SINGOUT
  void sendMail() {
    final Uri emailUri = Uri(scheme: "mailto", path: "sharonshaji127001@gmail.com");
    //final urlType =
    _launchURL(emailUri);
    //print("type : ${urlType.runtimeType}");
  }

  void openWebsite() => _launchURL(Uri.parse("https://sbcollege.ac.in"));

  _launchURL(url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }
}
