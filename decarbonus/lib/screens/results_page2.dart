import 'package:decarbonus/constants.dart';
import 'package:decarbonus/screens/dashboard.dart';
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
    ChartData('Travel', results['travel'], const Color(0xFFBEE5B0)),
    ChartData('Diet', results['diet'], const Color(0xFF71BC68)),
    ChartData('Car Travel', results['carTravel'], const Color(0xFFBEE5B0)),
    ChartData('Fuel', results['fuel'], const Color.fromARGB(255, 6, 96, 66)),
    ChartData('Shopping', results['shopping'],
        const Color.fromARGB(255, 38, 168, 95)),
    ChartData('Home Size', results['homeSize'], Colors.green.shade500),
    ChartData('Members', results['homePeople'], Colors.green.shade400),
    ChartData('Pet', results['pet'], Colors.green.shade800),
  ];

  @override
  Widget build(BuildContext context) {
    return results == null
        ? const Center(
            child: Text('Something went wrong'),
          )
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 70),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                // Chart title
                title: ChartTitle(text: 'Categorical Co2 Emmissions'),
                // Enable legend
                legend: Legend(isVisible: true),
                palette: const [Color(0xFF28B67E)],
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                      dataSource: chartData,
                      pointColorMapper: (ChartData data, _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      name: 'Co2 tons / year',
                      // Enable data label
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true))
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
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
          );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final dynamic y;
  final Color? color;
}
