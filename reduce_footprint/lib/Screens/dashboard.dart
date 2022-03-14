import 'package:flutter/material.dart';
import 'package:reduce_footprint/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: kPrimaryColor,
      ),
      body: const Center(
        child: Text('Dashboard Page'),
      ),
    );
  }
}