import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reduce_footprint/Auth/auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reduce_footprint/Auth/google_auth.dart';
import '../../../constants.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 1.0 : 0.0,
      duration: widget.animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: widget.size.width,
          height: widget.defaultLoginSize,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(height: 20.sp),
                Image.asset('assets/images/nature.png', height: 200.sp),
                const SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.w),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: widget.size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kPrimaryColor.withAlpha(50)),
                  child: TextField(
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.mail, color: kPrimaryColor),
                        hintText: 'Email',
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: widget.size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kPrimaryColor.withAlpha(50)),
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwController,
                    cursorColor: kPrimaryColor,
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock, color: kPrimaryColor),
                      hintText: 'Password',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Authentication(
                      context: context,
                      email: _emailController.text,
                      password: _passwController.text,
                    ).logIn();
                    _emailController.clear();
                    _passwController.clear();
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 280.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kPrimaryColor,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('OR',
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold)),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0, top: 8.0),
                  child: Text('Log-In Using',
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(width: 60),
                    InkWell(
                      onTap: () {
                        GoogleSignInProvider(
                          context: context,
                        ).googleLogin();
                      },
                      child: SvgPicture.asset('assets/logo/google.svg',
                          height: 40.sp),
                    ),
                    SvgPicture.asset('assets/logo/facebook.svg', height: 50.sp),
                    const SizedBox(width: 60),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
