import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reduce_footprint/Screens/getting_started.dart';

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
      final UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (user.user != null) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => GettingStarted(
              email: user.user!.email,
              name: user.user!.displayName,
              img: user.user!.photoURL,
            ),
          ),
        );
      }
    } on FirebaseException catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5,
            shape: const RoundedRectangleBorder(
                side: BorderSide(width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            backgroundColor: Colors.green.shade300,
            title: const Text('Error 😢'),
            content: Text(e.message.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
        },
      );
    }
  }
}
