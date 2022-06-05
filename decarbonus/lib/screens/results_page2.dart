import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decarbonus/constants.dart';
import 'package:decarbonus/screens/dashboard.dart';
import 'package:decarbonus/screens/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../utils/global_variable.dart';

class IndividualEmmission extends StatefulWidget {
  const IndividualEmmission({Key? key}) : super(key: key);

  @override
  State<IndividualEmmission> createState() => _IndividualEmmissionState();
}

class _IndividualEmmissionState extends State<IndividualEmmission> {
  final List<ChartData> chartData = [
    ChartData('Travel', results['travel']),
    ChartData('Diet', results['diet']),
    ChartData('Car Travel', results['carTravel']),
    ChartData('Fuel', results['fuel']),
    ChartData('Shopping', results['shopping']),
    ChartData('Home Size', results['homeSize']),
    ChartData('Members', results['homePeople']),
    ChartData('Pet', results['pet']),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: results == null
          ? const Center(
              child: Text('Something went wrong'),
            )
          : Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 70),
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
                  title: ChartTitle(text: 'Your Individual Co2 Emmissions'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<ChartData, String>>[
                    ColumnSeries<ChartData, String>(
                        dataSource: chartData,
                        pointColorMapper: (ChartData data, _) => data.color,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
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
                label: const Text('Start Off-setting ➔'),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const Dashboard(),
                  ),
                ),
              ),
            ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final dynamic y;
  final Color? color;
}
