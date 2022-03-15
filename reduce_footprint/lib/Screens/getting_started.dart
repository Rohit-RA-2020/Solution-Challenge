import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:reduce_footprint/Screens/dashboard.dart';
import 'package:reduce_footprint/Screens/questions.dart';
import 'package:reduce_footprint/store.dart';
import '../constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  late CollectionReference _collectionReference;

  @override
  void initState() {
    _collectionReference = FirebaseFirestore.instance.collection(email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    email = widget.user.email;
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
                    color: kPrimaryColor),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 130.sp),
                SizedBox(
                  child: Center(
                    child: Text(
                      'Welcome, ${widget.user.displayName ?? 'User'}',
                      style: GoogleFonts.kalam(fontSize: 22.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  child: Center(
                    child: Text(
                      'Before we continue, Please answer some questions',
                      style: GoogleFonts.kalam(fontSize: 20.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Lottie.asset('assets/lottie/loading.json'),
                SizedBox(
                  height: 70.sp,
                  width: 200.sp,
                  child: ElevatedButton(
                    child: Text(
                      'Get Started',
                      style: TextStyle(fontSize: 18.sp),
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
                      backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          side: const BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
