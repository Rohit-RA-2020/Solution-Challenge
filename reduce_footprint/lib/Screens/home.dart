import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Image.network(img!), Text(name!), Text(email!)],
          ),
        ),
      ),
    );
  }
}
