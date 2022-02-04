import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:reduce_footprint/Screens/getting_started.dart';

class FacebookSignProvider {
  void signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // Create a credential from the access token
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        // Once signed in, return the UserCredential
        final UserCredential user =
            await FirebaseAuth.instance.signInWithCredential(credential);
        if (user.user != null) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => GettingStarted(
                user: user.user!,
              ),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
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
