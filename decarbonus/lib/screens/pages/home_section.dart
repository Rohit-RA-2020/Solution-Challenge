import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../utils/global_variable.dart';
import '../weekly_activities.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String cdate = DateFormat("dd MMMM, yyyy").format(DateTime.now());
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF5BB462),
                    Color(0xFF86C232),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
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
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
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
                      string: 'Transport',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WeeklyActivities(
                              activityName: 'travel',
                            ),
                          ),
                        );
                      },
                    ),
                    InfoContainer(
                      icon: Icons.food_bank_outlined,
                      string: 'Food',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WeeklyActivities(
                                activityName: 'food',
                              ),
                            ));
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    InfoContainer(
                      icon: Icons.emoji_transportation,
                      string: 'Transport',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WeeklyActivities(
                                activityName: 'travel',
                              ),
                            ));
                      },
                    ),
                    InfoContainer(
                      icon: Icons.food_bank_outlined,
                      string: 'food',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WeeklyActivities(
                                activityName: 'transport',
                              ),
                            ));
                      },
                    ),
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

class InfoContainer extends StatefulWidget {
  final IconData icon;
  final String string;
  final void Function()? onTap;

  const InfoContainer(
      {Key? key, required this.icon, required this.string, required this.onTap})
      : super(key: key);

  @override
  State<InfoContainer> createState() => _InfoContainerState();
}

class _InfoContainerState extends State<InfoContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.22,
        width: MediaQuery.of(context).size.width / 2.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              widget.icon,
              size: 50,
              color: Colors.white,
            ),
            Text(
              widget.string,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF5BB462),
              Color(0xFF86C232),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
