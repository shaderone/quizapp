import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class DrawerMenuController extends GetxController {
  final drawerMenuController = ZoomDrawerController();

  @override
  void onReady() {
    //get user from firebase
  }

  void toggleDrawer() {
    drawerMenuController.toggle?.call();
    update();
  }

  // ** All Task for each menu item

  void signIn() {}

  void signOut() {}

  void sendMail() {
    final Uri emailUri = Uri(scheme: "mailto", path: "sbc@sbcollege.ac.in");
    _launchUrl(emailUri.toString());
  }

  void openWebsite() {}

  Future<void> _launchUrl(String url) async {
    //if (!await _launchUrl(url)) {
    //  throw Exception('Could not launch $url');
    //}
  }
}
