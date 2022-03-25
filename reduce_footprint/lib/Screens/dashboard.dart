import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:reduce_footprint/responsive/mobile_screen_layout.dart';
import 'package:reduce_footprint/screens/profile_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late CollectionReference _collectionReference;

  @override
  void initState() {
    _collectionReference = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!);
    super.initState();
  }

  int _bottomNavIndex = 0;
  List<IconData> iconList = [
    Icons.home_outlined,
    Icons.local_library_outlined,
    Icons.library_books_outlined,
    Icons.person_outline,
  ];

  final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const Maps(),
    const Blogs(),
    ProfileScreen(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfffcf5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          'Become a enviroment hero',
          style: TextStyle(color: Colors.black, fontSize: 19),
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
          IconButton(
            tooltip: 'Help',
            onPressed: () {},
            icon: const Icon(
              Icons.help_outline,
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
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MobileScreenLayout(),
          ),
        ),
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
      style: TextStyle(
        color: Colors.black,
      ),
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
      style: TextStyle(
        color: Colors.black,
      ),
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
      style: TextStyle(
        color: Colors.black,
      ),
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
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }
}
