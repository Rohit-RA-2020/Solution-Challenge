import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GettingStarted extends StatelessWidget {
  const GettingStarted({
    Key? key,
    required this.email,
    required this.name,
    required this.img,
  }) : super(key: key);

  final String? email;
  final String? name;
  final String? img;

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
                      'Before we continue, Please answer some questions',
                      style: GoogleFonts.supermercadoOne(fontSize: 20.sp),
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
                    onPressed: () {},
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
                SizedBox(height: 110.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
