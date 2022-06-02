import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decarbonus/screens/dashboard.dart';
import 'package:decarbonus/screens/questions.dart';
import 'package:lottie/lottie.dart';
import 'package:decarbonus/utils/global_variable.dart';

import '../utils/utils.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  late String uid;
  var userData = {};
  bool isLoading = false;

  @override
  void initState() {
    uid = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });

    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String name = userData['username'] ?? nameStarted;
    nameStarted = name;
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
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
                      const SizedBox(height: 130),
                      SizedBox(
                        child: Center(
                          child: Text(
                            'Welcome, ' + name,
                            style: GoogleFonts.roboto(fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Center(
                          child: Text(
                            'Before we continue, Please answer some questions',
                            style: GoogleFonts.roboto(fontSize: 20),
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
                            var userSnap = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .get();
                            var response = userSnap['responses'];
                            if (!response.isEmpty) {
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
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
