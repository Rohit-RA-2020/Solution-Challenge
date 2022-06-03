import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../utils/global_variable.dart';
import '../weekly_activities.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<bool> isChecked = [false, false, false];
  @override
  Widget build(BuildContext context) {
    String cdate = DateFormat("dd MMMM, yyyy").format(DateTime.now());
    return Scaffold(
      body: results != null
          ? ListView(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF5AAB61),
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
                          color: Color(0xFF0D1321),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    subtitle: Text(
                      cdate,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D1321),
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
                    percent: 1,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          results['result'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 45.0,
                            color: Color.fromARGB(255, 6, 96, 66),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "tons Co2 / yr",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Color(0xFF61892F)),
                        ),
                        const Text(
                          "Is your current",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Color(0xFF1D4C4F),
                          ),
                        ),
                        const Text(
                          "carbon footprint",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Color(0xFF1D4C4F),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: const Color.fromARGB(255, 6, 96, 66),
                    addAutomaticKeepAlive: true,
                    animationDuration: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, right: 25.0, bottom: 20),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.lightBlue.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(4, 8), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Your Today's task",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Color(0xFF1D4C4F),
                          ),
                        ),
                        todayTask('Travel with car pooling',
                            const Icon(Icons.car_rental), 0),
                        todayTask(
                            'Eat Vegan Today', const Icon(Icons.food_bank), 1),
                        const SizedBox(height: 10),
                        const Text(
                          'Bonus task',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Color(0xFF1D4C4F),
                          ),
                        ),
                        todayTask('Plant a tree', const Icon(Icons.nature), 2),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InfoContainer(
                              icon: Icons.emoji_transportation,
                              string: 'Transport',
                              bgColor: const Color(0xFFBEE5B0),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const WeeklyActivities(
                                      activityName: 'travel',
                                    ),
                                  ),
                                );
                              },
                            ),
                            InfoContainer(
                              icon: Icons.food_bank_outlined,
                              bgColor: const Color(0xFF71BC68),
                              string: 'Food',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const WeeklyActivities(
                                      activityName: 'food',
                                    ),
                                  ),
                                );
                              },
                            ),
                            InfoContainer(
                              icon: Icons.shopping_bag,
                              bgColor: const Color.fromARGB(255, 38, 168, 95),
                              string: 'Shopping',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const WeeklyActivities(
                                      activityName: 'shopping',
                                    ),
                                  ),
                                );
                              },
                            ),
                            InfoContainer(
                              icon: Icons.oil_barrel,
                              bgColor: const Color.fromARGB(255, 6, 96, 66),
                              string: 'Fuel',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const WeeklyActivities(
                                      activityName: 'fuel',
                                    ),
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
              ],
            )
          : const CircularProgressIndicator(),
    );
  }

  Padding todayTask(String name, Icon icon, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: CheckboxListTile(
        secondary: icon,
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Color(0xFF1D4C4F),
          ),
        ),
        value: isChecked[index],
        checkColor: Colors.white,
        activeColor: const Color(0xFF1D4C4F),
        onChanged: (bool? value) {
          setState(() {
            isChecked[index] = value!;
            if (isChecked.every((element) {
              return element == true;
            })) {
              taskComplete();
            }
          });
        },
      ),
    );
  }

  void taskComplete() {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Lottie.asset('assets/lottie/confetti.json'),
            AlertDialog(
              title: const Text('Task Completed'),
              content: const Text('Yay, you completed day 1 task'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class InfoContainer extends StatefulWidget {
  final IconData icon;
  final String string;
  final void Function()? onTap;
  final Color bgColor;

  const InfoContainer({
    Key? key,
    required this.icon,
    required this.string,
    required this.onTap,
    required this.bgColor,
  }) : super(key: key);

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
              color: Colors.black,
            ),
            Text(
              widget.string,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.bgColor,
        ),
      ),
    );
  }
}
