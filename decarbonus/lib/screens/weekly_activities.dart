import 'package:decarbonus/screens/activity_list.dart';
import 'package:decarbonus/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../store.dart';
import '../utils/global_variable.dart';

String actname = '';

class WeeklyActivities extends StatefulWidget {
  const WeeklyActivities({
    Key? key,
    required this.activityName,
  }) : super(key: key);

  final String activityName;

  @override
  _WeeklyActivitiesState createState() => _WeeklyActivitiesState();
}

class _WeeklyActivitiesState extends State<WeeklyActivities> {
  @override
  Widget build(BuildContext context) {
    actname = widget.activityName;
    String aname =
        widget.activityName[0].toUpperCase() + widget.activityName.substring(1);
    String emission = widget.activityName == 'food'
        ? results['diet'].toString()
        : results[widget.activityName].toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(aname),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Lottie.asset(
            activityAvatar[widget.activityName]!,
            height: 150,
            width: 150,
          ),
          const SizedBox(
            height: 5,
            child: Divider(
              color: Colors.black38,
              thickness: 3,
              endIndent: 100,
              indent: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  const TextSpan(
                      text:
                          'Your contribution to the carbon emmission through '),
                  TextSpan(
                      text: aname,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' activity is '),
                  TextSpan(
                      text: emission,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' tons of C02 / yr'),
                ],
              ),
            ),
          ),
          const Text(
            'Need help in reducing?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Lottie.asset('assets/lottie/path.json', fit: BoxFit.scaleDown),
          ),
          const Padding(
            padding: EdgeInsets.only(
                left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
            child: Text(
              'Here follow some of our curated tracks to help you reduce your carbon footprint',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const WeekWidget(
            week: 'Week 1',
            icon: Icon(null),
          ),
          const SizedBox(
            height: 15,
          ),
          const WeekWidget(
            week: 'Week 2',
            icon: Icon(Icons.lock),
          ),
          const SizedBox(
            height: 15,
          ),
          const WeekWidget(
            week: 'Week 3',
            icon: Icon(Icons.lock),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
            child: Card(
              elevation: 10,
              color: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text('Some Facts',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      activitydesc[widget.activityName]!,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
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
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: InkWell(
        onTap: () {
          if (week != 'Week 1') {
            showSnackBar(context, '$week is locked, complete week 1 first');
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActivityList(activityName: actname),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: const Color(0xFF1DBF73),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ),
          child: ListTile(
            title: Text(
              week,
              style: const TextStyle(
                  color: Color(0xFF0D1321), fontWeight: FontWeight.w500),
            ),
            trailing: icon,
          ),
        ),
      ),
    );
  }
}
