import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.green),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'DeCarbonUs',
                style: GoogleFonts.pacifico(
                  fontSize: 50,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                'DeCarbonUs is an App-based solution to help fight climate change by facilitating individuals to reduce and control their carbon footprint. With our app, we focus on solving United Nations Sustainable Development Goals (SDGs) by providing a platform for users to track their carbon footprint and achieve their goals.\n\nWe are a team of four students from GHRCE, and are currently working on the app to improve it further.',
                style:
                    GoogleFonts.rancho(fontSize: 25, color: Colors.blue[900]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                'We aim to target',
                style: GoogleFonts.rancho(fontSize: 30),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.network(
                  'https://developers.google.com/community/images/gdsc-solution-challenge/goal-03_480.png',
                  width: 100,
                ),
                Image.network(
                  'https://developers.google.com/community/images/gdsc-solution-challenge/goal-12_480.png',
                  width: 100,
                ),
                Image.network(
                  'https://developers.google.com/community/images/gdsc-solution-challenge/goal-13_480.png',
                  width: 100,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: 10,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: Text(
                'Want to know more or contribute to the project? Check out our Github page!',
                style: GoogleFonts.rancho(fontSize: 25),
              ),
            ),
            IconButton(
                onPressed: () {
                  launchUrl(Uri.parse(
                      'https://github.com/Rohit-RA-2020/Solution-Challenge/'));
                },
                icon: const Icon(FontAwesomeIcons.github, size: 30)),
          ],
        ),
      ),
    );
  }
}
