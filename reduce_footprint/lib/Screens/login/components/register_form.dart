import 'package:flutter/material.dart';
import 'package:reduce_footprint/components/rounded_button.dart';
import 'package:reduce_footprint/components/rounded_input.dart';
import 'package:reduce_footprint/components/rounded_password_input.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
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
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLogin ? 0.0 : 1.0,
      duration: animationDuration * 5,
      child: Visibility(
        visible: !isLogin,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: size.width,
            height: defaultLoginSize,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Welcome',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 40),
                  Image.asset('assets/images/nature1.png', height: 200),
                  const SizedBox(height: 40),
                  const RoundedInput(icon: Icons.mail, hint: 'Username'),
                  const RoundedInput(icon: Icons.face_rounded, hint: 'Name'),
                  const RoundedPasswordInput(hint: 'Password'),
                  const SizedBox(height: 10),
                  const RoundedButton(title: 'SIGN UP'),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
