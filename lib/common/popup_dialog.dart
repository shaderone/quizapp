import 'package:flutter/material.dart';

class Dialogs {
  Dialogs._internal();
  static final Dialogs dialogInstance = Dialogs._internal();

  factory Dialogs() => dialogInstance;

  //the method is static because the class is singleton
  static Widget showSignInDialog({required VoidCallback onTap, required BuildContext context, required String title}) {
    return AlertDialog(
      title: const Text("Hi, there"),
      content: Text("Please Login before you start the $title test"),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("back")),
        TextButton(onPressed: () {}, child: const Text("Login")),
      ],
    );
  }
}
