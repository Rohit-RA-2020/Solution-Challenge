import 'package:decarbonus/screens/activityList.dart';
import 'package:flutter/material.dart';

class WeeklyActivities extends StatefulWidget {
  const WeeklyActivities({Key? key}) : super(key: key);

  @override
  _WeeklyActivitiesState createState() => _WeeklyActivitiesState();
}

class _WeeklyActivitiesState extends State<WeeklyActivities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          'Your Activities',
        ),
      ),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Travel',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'CO2 emissions per passenger-kilometre (pkm) for all road travel for 2011 in Europe as provided by the European Environment Agency: 109 g/km CO2',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 15,
            child: Divider(
              color: Colors.black38,
              thickness: 3,
              endIndent: 100,
              indent: 100,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Food',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Food contributes 10-30% of a household’s carbon footprint, mainly attributed to agricultural practices like food production and transportation. Meat products have larger carbon footprints than plant products like vegetables and grains due to inefficient conversion of plant energy to animals, and the release of methane from manure.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 15,
            child: Divider(
              color: Colors.black38,
              thickness: 3,
              endIndent: 100,
              indent: 100,
            ),
          ),
          WeekWidget(
            week: 'Week 1',
            icon: Icon(null),
          ),
          SizedBox(
            height: 15,
          ),
          WeekWidget(
            week: 'Week 2',
            icon: Icon(Icons.lock),
          ),
          SizedBox(
            height: 15,
          ),
          WeekWidget(
            week: 'Week 3',
            icon: Icon(Icons.lock),
          ),
        ],
      ),
    );
  }
}

class WeekWidget extends StatelessWidget {
  final String week;
  final Icon icon;
  const WeekWidget({
    Key? key,
    required this.week,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (Context) => ActivityList(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: const Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
        ),
        child: ListTile(
          title: Text(week),
          trailing: icon,
        ),
      ),
    );
  }
}
