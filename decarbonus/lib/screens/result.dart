import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decarbonus/screens/results_page2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:decarbonus/screens/dashboard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../utils/colors.dart';
import '../utils/global_variable.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<_CarbonData> data = [
    _CarbonData('You Are Here', results.data['result'].toDouble()),
    _CarbonData('Global Traget \n You need to be here', 2.0)
  ];

  @override
  void initState() {
    setResult();
    super.initState();
  }

  void setResult() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User currentUser = _auth.currentUser!;
    var userSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
    try {
      results = userSnap['result'];
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: results == null
          ? const Center(
              child: Text('Something went wrong'),
            )
          : Scaffold(
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 70, horizontal: 25),
                child: SfCartesianChart(
                  palette: const [
                    Colors.green,
                    Colors.red,
                    Colors.orange,
                    Colors.yellow,
                    Colors.blue
                  ],
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Your Co2 Emmissions'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_CarbonData, String>>[
                    ColumnSeries<_CarbonData, String>(
                        dataSource: data,
                        yValueMapper: (_CarbonData carbon, _) => carbon.tons,
                        xValueMapper: (_CarbonData carbon, _) => carbon.year,
                        name: 'Co2',
                        // Enable data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true))
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: kPrimaryColor,
                label: const Text('View Individual Emmission ➔'),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const IndividualEmmission(),
                  ),
                ),
              ),
            ),
    );
  }
}

class _CarbonData {
  _CarbonData(this.year, this.tons);

  final String year;
  final double tons;
}
