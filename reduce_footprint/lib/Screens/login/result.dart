import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({Key? key, required this.result}) : super(key: key);
  final dynamic result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Your Average Yearly carbon Footprint is ' +
            result.data['result'].toString() +
            ' tons CO2'),
      ),
    );
  }
}
