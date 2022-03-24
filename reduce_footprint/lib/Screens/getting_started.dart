import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reduce_footprint/responsive/mobile_screen_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reduce_footprint/screens/dashboard.dart';
import 'package:reduce_footprint/screens/questions.dart';
import 'package:reduce_footprint/utils/global_variable.dart';
import 'package:lottie/lottie.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  late CollectionReference _collectionReference;

  @override
  void initState() {
    // email = widget.user.email;
    _collectionReference = FirebaseFirestore.instance.collection(emaill!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -80,
              right: -80,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.green),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 130),
                SizedBox(
                  child: Center(
                    child: Text(
                      'Welcome, User',
                      style: GoogleFonts.kalam(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  child: Center(
                    child: Text(
                      'Before we continue, Please answer some questions',
                      style: GoogleFonts.kalam(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Lottie.asset('assets/lottie/loading.json'),
                SizedBox(
                  height: 70,
                  width: 200,
                  child: ElevatedButton(
                    child: const Text(
                      'Get Started',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () async {
                      var userDocRef = _collectionReference.doc('responses');
                      var doc = await userDocRef.get();
                      if (doc.exists) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const Dashboard(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const Questions(),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(10.0),
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          side: const BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
