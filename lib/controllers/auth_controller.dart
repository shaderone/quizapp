import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app/common/popup_dialog.dart';
import 'package:quiz_app/firebase_ref/references.dart';
import 'package:quiz_app/screens/login/login_screen.dart';

class AuthController extends GetxController {
  late FirebaseAuth auth;
  // ** the Rxn (n - null safe) to retrieve data from firebase when using getx
  final _user = Rxn<User>();
  // ** will determine if the user is logged in or not
  //the User? may be null, because they may not be loggedin
  late Stream<User?> authStateChanges;

  @override
  Future<void> onReady() async {
    // ? This function checks for an active user, if found it gets that user info.
    await initAuth();
    super.onReady();
  }

  Future<void> initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    auth = FirebaseAuth.instance;
    // The _authStateChanges will hold the info about user State changes, ie; logged in or out.
    authStateChanges = auth.authStateChanges();
    //Listen for a change, if user, the user is authenticated successfully.
    authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToOnboardingScreen();
  }

  //If user not found, we use google signin method to authenticate the user, And the credentials are sent to firebase backend.
  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      //*
      //-> Initiate signIn with google
      //-> check for account
      //-> if account is found, get the creds
      //-> send the cred to firebase using its googleSignIn method.
      //-> user is now authenticated, and the user data is stored in firebase.
      // */
      //we'll try to get account from google, using the googleSignIn method
      GoogleSignInAccount? googleAccount = await googleSignIn.signIn();

      if (googleAccount != null) {
        //if account exists, get the authentication object from google. this object will have the unique token and access id.
        final authAccount = await googleAccount.authentication;
        //this class is from firebase auth, we get the account creds from the googleSignIn method.
        final credential = GoogleAuthProvider.credential(idToken: authAccount.idToken, accessToken: authAccount.accessToken);
        //login to the app with the credentials got from the google account.
        await auth.signInWithCredential(credential);

        saveUserToDataBase(googleAccount);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void saveUserToDataBase(GoogleSignInAccount googleAccount) {
    userRFC.doc(googleAccount.email).set({
      //based on the users email, we are creating new user collection with the following document with these fields
      "email": googleAccount.email,
      "name": googleAccount.displayName,
      "profile_pic": googleAccount.photoUrl,
    });
  }

  void showLoginPopup(context, title) {
    Get.dialog(
      Dialogs.showSignInDialog(
        onTap: () {
          //remove the current page
          Get.back();
          navigateToLoginScreen();
        },
        context: context,
        title: title,
      ),
      //barrierDismissible: true, allow box to be dismissed.
    );
  }

  bool isUserLoggedIn() => auth.currentUser != null;

  void navigateToOnboardingScreen() => Get.offAllNamed("/onboarding");

  void navigateToLoginScreen() => Get.toNamed(LoginScreen.loginRouteName);
}
