import 'package:decarbonus/screens/weeklyActivities.dart';
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
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
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
          Padding(
            padding: const EdgeInsets.all(8),
            child: CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 13.0,
              animation: true,
              percent: 0.5,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "You're on track",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Color(0xFF6B6E70),
                    ),
                  ),
                  Text(
                    "to reduce emission by",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Color(0xFF6B6E70),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "50%",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45.0,
                        color: Color(0xFF222629)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "this month",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Color(0xFF61892F)),
                  ),
                ],
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: const Color(0xFF86C232),
              addAutomaticKeepAlive: true,
              animationDuration: 2,
            ),
          ),
          const SizedBox(
            height: 40,
            child: Divider(
              color: Color(0xFF6B6E70),
              thickness: 3,
              endIndent: 100,
              indent: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_circle_rounded,
                            size: 60,
                            color: Colors.green.shade100,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Total Emission',
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                            ),
                            child: LinearPercentIndicator(
                              animation: true,
                              lineHeight: 18.0,
                              animationDuration: 2000,
                              percent: 0.4,
                              progressColor: const Color(0xFF86C232),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            '40%',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    height: 210,
                    width: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B6E70),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.emoji_transportation,
                            size: 60,
                            color: Colors.green.shade100,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Transport',
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                            ),
                            child: LinearPercentIndicator(
                              animation: true,
                              lineHeight: 18.0,
                              animationDuration: 2000,
                              percent: 0.16,
                              progressColor: const Color(0xFF86C232),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            '16%',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    height: 210,
                    width: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B6E70),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.food_bank,
                            size: 60,
                            color: Colors.green.shade100,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Food',
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                            ),
                            child: LinearPercentIndicator(
                              animation: true,
                              lineHeight: 18.0,
                              animationDuration: 2000,
                              percent: 0.70,
                              progressColor: const Color(0xFF86C232),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            '70%',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    height: 210,
                    width: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B6E70),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
            child: Divider(
              color: Color(0xFF6B6E70),
              thickness: 3,
              endIndent: 100,
              indent: 100,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            decoration: BoxDecoration(
                color: const Color(0xFF61892F),
                borderRadius: BorderRadius.circular(10)),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Record Emission  +',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
