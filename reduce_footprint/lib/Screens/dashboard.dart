import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../store.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late CollectionReference _collectionReference;

  @override
  void initState() {
    _collectionReference = FirebaseFirestore.instance.collection(email!);
    super.initState();
  }

  int _bottomNavIndex = 0;
  List<IconData> iconList = [
    Icons.home_outlined,
    Icons.local_library_outlined,
    Icons.library_books_outlined,
    Icons.person_outline,
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Maps(),
    Blogs(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          'Become a enviroment hero',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            tooltip: 'Erase your responses',
            onPressed: () async {
              await _collectionReference.doc('responses').delete();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.question_answer,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_bottomNavIndex),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.compost_outlined),
        backgroundColor: Colors.pink,
        onPressed: () {},
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Colors.black87,
        icons: iconList,
        splashColor: Colors.green,
        inactiveColor: Colors.white,
        activeColor: Colors.lightGreen,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Home Page',
    );
  }
}

class Maps extends StatelessWidget {
  const Maps({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Maps Page',
    );
  }
}

class Blogs extends StatelessWidget {
  const Blogs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Blogs Page',
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Profile Page',
    );
  }
}
