import 'package:flutter/material.dart';

class ActivityList extends StatefulWidget {
  const ActivityList({Key? key}) : super(key: key);

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
        children: const [
          DayWiseActivity(
            day: 'Day 1',
          ),
          SizedBox(
            height: 15,
          ),
          DayWiseActivity(
            day: 'Day 2',
          ),
          SizedBox(
            height: 15,
          ),
          DayWiseActivity(
            day: 'Day 3',
          ),
          SizedBox(
            height: 15,
          ),
          DayWiseActivity(
            day: 'Day 4',
          ),
          SizedBox(
            height: 15,
          ),
          DayWiseActivity(
            day: 'Day 5',
          ),
          SizedBox(
            height: 15,
          ),
          DayWiseActivity(
            day: 'Day 6',
          ),
          SizedBox(
            height: 15,
          ),
          DayWiseActivity(
            day: 'Day 7',
          ),
        ],
      ),
    );
  }
}

class DayWiseActivity extends StatelessWidget {
  final String day;
  const DayWiseActivity({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          title: Text(day),
          children: const <Widget>[
            ListTile(
              title: Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
