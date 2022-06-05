import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decarbonus/constants.dart';
import 'package:decarbonus/screens/results_menu.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:decarbonus/Screens/login/login.dart';
import 'package:decarbonus/Screens/pages/blogs_section.dart';
import 'package:decarbonus/Screens/pages/home_section.dart';
import 'package:decarbonus/Screens/pages/maps_section.dart';
import 'package:decarbonus/models/blogs_model.dart';
import 'package:decarbonus/responsive/mobile_screen_layout.dart';
import 'package:decarbonus/screens/about.dart';
import 'package:decarbonus/screens/leaderboard.dart';
import 'package:decarbonus/screens/profile_screen.dart';
import 'package:decarbonus/utils/global_variable.dart';
import 'package:decarbonus/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../resources/auth_methods.dart';
import '../store.dart';

var userData = {};

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void apiCall() async {
    String? jsonRespose;
    var dio = Dio();
    await dio
        .get('https://api-account-345807.el.r.appspot.com/blogs',
            options: Options(responseType: ResponseType.plain, headers: {
              'Content-Type': 'application/json;charset=UTF-8',
              'Charset': 'utf-8'
            }))
        .then((response) {
      setState(() {
        jsonRespose = response.data.toString();
      });
    });

    blogPost = blogPostFromJson(jsonRespose!);
  }

  void setResult() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User currentUser = _auth.currentUser!;
    var userSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
    results = userSnap['result'];
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  void initState() {
    apiCall();
    getData();
    setResult();
    super.initState();
  }

  int _bottomNavIndex = 0;
  List<IconData> iconList = [
    Icons.home_outlined,
    Icons.local_library_outlined,
    Icons.library_books_outlined,
    Icons.person_outline,
  ];

  final List<String> appTitle = [
    'Become a enviroment hero',
    'Explore local events',
    'Read blogs',
    'Profile',
  ];

  final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const Maps(),
    const Blogs(),
    ProfileScreen(
      uid: FirebaseAuth.instance.currentUser!.uid,
      isSearch: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SafeArea(
        child: DrawerWidget(),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.green),
          elevation: 0,
          title: Text(
            appTitle[_bottomNavIndex],
            style: const TextStyle(color: Colors.black, fontSize: 19),
          ),
          backgroundColor: Colors.white),
      body: Center(child: _widgetOptions.elementAt(_bottomNavIndex)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.compost_outlined),
        backgroundColor: Colors.black,
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
        backgroundColor: const Color(0xFF0D1321),
        icons: iconList,
        iconSize: 25,
        splashColor: Colors.green,
        inactiveColor: Colors.white,
        activeColor: Colors.lightGreen,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
    );
  }
}

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String _url =
      'https://docs.google.com/forms/d/e/1FAIpQLSfTrOXev2oIMr0Az1vVozF9MZQ-skkfW93xxAorywICMmye6g/viewform?usp=sf_link';

  void _launchURL() async {
    if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color(0xFF0D1321),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          userData['photoUrl'],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData['username'],
                            style: const TextStyle(
                                fontSize: 20,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            FirebaseAuth.instance.currentUser!.email!,
                            style: const TextStyle(
                                fontSize: 14, color: kPrimaryColor),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Divider(thickness: 1.1, color: Colors.black),
                  buildMenuItem(
                      text: 'Leaderboard',
                      icon: Icons.leaderboard_outlined,
                      onClicked: () {
                        selectedItem(context, 2);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LeaderBoard(),
                          ),
                        );
                      }),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Your Emission',
                    icon: Icons.gas_meter_outlined,
                    onClicked: () {
                      selectedItem(context, 3);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const YourEmission(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Clear responses',
                    icon: Icons.delete_outline,
                    onClicked: () async {
                      User currentUser = _auth.currentUser!;
                      await _collectionReference.doc(currentUser.uid).set(
                        {'responses': []},
                        SetOptions(
                          merge: true,
                        ),
                      );
                      selectedItem(context, 0);
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Give Feedback',
                    icon: Icons.feedback_outlined,
                    onClicked: () {
                      _launchURL();
                      selectedItem(context, 1);
                    },
                  ),
                  const SizedBox(height: 24),
                  const Divider(thickness: 1.1, color: Colors.black),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'About',
                    icon: Icons.help_center_outlined,
                    onClicked: () {
                      selectedItem(context, 3);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const About(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'SignOut',
                    icon: Icons.exit_to_app_outlined,
                    onClicked: () async {
                      FirebaseAuth.instance.signOut();
                      await AuthMethods().signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LogScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() => InkWell(
        onTap: () {},
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/decarbonus-banner.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20)
              .add(const EdgeInsets.symmetric(vertical: 40)),
          child: const SizedBox(height: 30),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    Color color = Colors.green.shade300;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color, size: 30),
      title: Text(text, style: TextStyle(color: color, fontSize: 18)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        break;
      case 1:
        break;

      default:
        break;
    }
  }
}
