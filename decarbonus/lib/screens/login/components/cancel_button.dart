import 'package:flutter/material.dart';
import 'package:decarbonus/constants.dart';

class CancelButton extends StatelessWidget {
  const CancelButton(
      {Key? key,
      required this.isLogin,
      required this.animationDuration,
      required this.size,
      required this.animationController,
      required this.tapEvent})
      : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final AnimationController animationController;
  final GestureTapCallback tapEvent;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLogin ? 0.0 : 1.0,
      duration: animationDuration,
      child: isLogin
          ? const SizedBox()
          : Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: isLogin ? 0 : size.width,
                height: isLogin ? 0 : size.height * 0.1,
                alignment: Alignment.bottomCenter,
                child: isLogin
                    ? Container()
                    : IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: tapEvent,
                        color: kPrimaryColor,
                      ),
              ),
            ),
    );
  }
}
