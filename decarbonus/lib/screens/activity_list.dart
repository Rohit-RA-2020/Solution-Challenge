import 'package:decarbonus/store.dart';
import 'package:flutter/material.dart';

class ActivityList extends StatefulWidget {
  const ActivityList({Key? key, required this.activityName}) : super(key: key);

  final String activityName;

  @override
  _ActivityListState createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Wise Activities'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          dayWiseActivity('Day 1', 1),
          const SizedBox(height: 15),
          dayWiseActivity('Day 2', 2),
          const SizedBox(height: 15),
          dayWiseActivity('Day 3', 3),
          const SizedBox(height: 15),
          dayWiseActivity('Day 4', 4),
          const SizedBox(height: 15),
          dayWiseActivity('Day 5', 5),
          const SizedBox(height: 15),
          dayWiseActivity('Day 6', 6),
          const SizedBox(height: 15),
          dayWiseActivity('Day 7', 7),
        ],
      ),
    );
  }

  Padding dayWiseActivity(String day, int index) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
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
        child: ExpansionTile(
          iconColor: const Color(0xFF28B67E),
          textColor: const Color(0xFF1D4C4F),
          title: Text(day),
          children: <Widget>[
            ListTile(
              title: Text(
                dayWise[widget.activityName]![index - 1],
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
