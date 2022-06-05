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
      await FirebaseAuth.instance.signInWithCredential(credential);
      String res = await AuthMethods().googleSign(
        username: _user!.displayName!,
        photoUrl: _user!.photoUrl == null
            ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'
            : _user!.photoUrl!,
        bio: 'Save Planet',
        email: _user!.email,
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
