import 'package:decarbonus/resources/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Screens/getting_started.dart';
import '../responsive/responsive_layout.dart';
import '../utils/utils.dart';

class GoogleSignInProvider {
  final BuildContext context;
  GoogleSignInProvider({required this.context});

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return null;
    }

    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);
      String res = await AuthMethods().googleSign(
        username: _user!.displayName!,
        photoUrl: _user!.photoUrl!,
        bio: 'Save Planet',
        email: _user!.email,
        userid: user.user!.uid,
      );
      if (res == 'success') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: GettingStarted(),
                webScreenLayout: GettingStarted(),
              ),
            ),
            (route) => false);
      } else {
        showSnackBar(context, res);
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}