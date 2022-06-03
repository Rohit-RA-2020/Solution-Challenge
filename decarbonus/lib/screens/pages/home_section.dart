import 'dart:ui';

import 'package:decarbonus/screens/weeklyActivities.dart';
import 'package:decarbonus/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../utils/global_variable.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String cdate = DateFormat("dd MMMM, yyyy").format(DateTime.now());
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF86C232),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://wallpaperaccess.com/full/3570972.png'),
                  backgroundColor: Colors.white54,
                  radius: 30,
                ),
                title: Text(
                  'Welcome, $nameStarted',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                subtitle: Text(
                  cdate,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6B6E70),
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Color(0xFF6B6E70),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WeeklyActivities(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Your Total Emission',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              CircularPercentIndicator(
                radius: 50,
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 2,
                backgroundColor: Colors.white54,
                center: Text('50%'),
                percent: 0.50,
                restartAnimation: true,
                progressColor: Colors.green,
                lineWidth: 8,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    InfoContainer(
                      icon: Icons.emoji_transportation,
                      percent: '25%',
                      percentage: 0.25,
                      string: 'Transport',
                    ),
                    InfoContainer(
                        icon: Icons.food_bank_outlined,
                        string: 'Food',
                        percent: '5%',
                        percentage: 0.05),
                  ],
                ),
                Row(
                  children: [
                    InfoContainer(
                      icon: Icons.emoji_transportation,
                      percent: '25%',
                      percentage: 0.25,
                      string: 'Transport',
                    ),
                    InfoContainer(
                        icon: Icons.food_bank_outlined,
                        string: 'Food',
                        percent: '5%',
                        percentage: 0.05),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  final IconData icon;
  final String string;
  final String percent;
  final double percentage;
  const InfoContainer({
    Key? key,
    required this.icon,
    required this.string,
    required this.percent,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height / 4.5,
      width: MediaQuery.of(context).size.width / 2.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.black54,
          ),
          Text(
            string,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          LinearPercentIndicator(
            width: 50,
            animation: true,
            animationDuration: 2,
            percent: percentage,
            leading: Text(percent),
            lineHeight: 15,
            alignment: MainAxisAlignment.center,
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
