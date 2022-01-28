import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reduce_footprint/Screens/home.dart';

class Authentication {
  String email;
  String password;
  BuildContext context;

  Authentication({
    required this.email,
    required this.password,
    required this.context,
  });

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5,
            shape: const RoundedRectangleBorder(
                side: BorderSide(width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            backgroundColor: Colors.green.shade300,
            title: const Text('User Created 😀'),
            content: const Text('Continue to Log in'),
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

  void logIn() async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(
              email: user.user!.email,
              name: 'User',
              img:
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Gnome-stock_person.svg/72px-Gnome-stock_person.svg.png',
            ),
          ),
        );
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