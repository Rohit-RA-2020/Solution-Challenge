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
        title: Text('Day Wise Activities'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.redAccent),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'huehue',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Completed',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          DayWiseActivity(
            day: 'Day1',
          ),
          SizedBox(
            height: 15,
          ),
          DayWiseActivity(
            day: 'Day2',
          ),
          SizedBox(
            height: 15,
          ),
          DayWiseActivity(
            day: 'Day3',
          ),
          SizedBox(
            height: 15,
          ),
          DayWiseActivity(
            day: 'Day4',
          ),
          SizedBox(
            height: 15,
          ),
          DayWiseActivity(
            day: 'Day5',
          ),
          SizedBox(
            height: 15,
          ),
          DayWiseActivity(
            day: 'Day6',
          ),
          SizedBox(
            height: 15,
          ),
          DayWiseActivity(
            day: 'Day7',
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
    return TextButton(
      onPressed: () {},
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
          title: Text(day),
          trailing: Icon(Icons.circle_outlined),
        ),
      ),
    );
  }
}
