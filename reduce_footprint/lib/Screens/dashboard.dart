import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:reduce_footprint/Screens/pages/blogs_section.dart';
import 'package:reduce_footprint/Screens/pages/home_section.dart';
import 'package:reduce_footprint/Screens/pages/maps_section.dart';
import 'package:reduce_footprint/models/blogs_model.dart';
import 'package:reduce_footprint/responsive/mobile_screen_layout.dart';
import 'package:reduce_footprint/screens/profile_screen.dart';
import 'package:reduce_footprint/screens/results_menu.dart';
import 'package:reduce_footprint/utils/global_variable.dart';
import 'package:reduce_footprint/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
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
    var userSnap = await FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc('results')
        .get();
    results = userSnap;
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
      backgroundColor: const Color(0xFFfffcf5),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.green),
        elevation: 0,
        title: Text(
          appTitle[_bottomNavIndex],
          style: const TextStyle(color: Colors.black, fontSize: 19),
        ),
        backgroundColor: Colors.transparent,
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

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late CollectionReference _collectionReference;
  @override
  void initState() {
    _collectionReference = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!);
    super.initState();
  }

  final String _url =
      'https://docs.google.com/forms/d/e/1FAIpQLSfTrOXev2oIMr0Az1vVozF9MZQ-skkfW93xxAorywICMmye6g/viewform?usp=sf_link';

  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 20);
    return Drawer(
      child: Material(
        color: const Color(0xFFE34A6F).withOpacity(0.7),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: userData['photoUrl'],
              name: userData['username'],
              email: FirebaseAuth.instance.currentUser!.email!,
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  const Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  buildMenuItem(
                    text: 'Clear responses',
                    icon: Icons.delete_outline,
                    onClicked: () async {
                      await _collectionReference.doc('responses').delete();
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
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Leaderboard',
                    icon: Icons.leaderboard_outlined,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Your Emission',
                    icon: Icons.gas_meter_outlined,
                    onClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const YourEmission(),
                        ),
                      ).then((value) => selectedItem(context, 3));
                      //selectedItem(context, 2);
                    },
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'About',
                    icon: Icons.help_center_outlined,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'SignOut',
                    icon: Icons.exit_to_app_outlined,
                    onClicked: () => selectedItem(context, 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
  }) =>
      InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20)
              .add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
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
