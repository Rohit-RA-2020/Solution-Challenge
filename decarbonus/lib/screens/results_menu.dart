import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../utils/global_variable.dart';

class YourEmission extends StatelessWidget {
  const YourEmission({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text('Your Emmission History',
              style: TextStyle(color: Colors.black)),
          bottom: const TabBar(
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
            tabs: [
              Tab(
                icon: Icon(FontAwesomeIcons.shoePrints, color: Colors.teal),
                text: 'Your emmission',
              ),
              Tab(
                icon: Icon(Icons.category),
                text: 'Category wise data',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TotalEmission(),
            const IndividualEmmission(),
          ],
        ),
      ),
    );
  }
}

class TotalEmission extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  TotalEmission({Key? key}) : super(key: key);

  @override
  TotalEmissionState createState() => TotalEmissionState();
}

class TotalEmissionState extends State<TotalEmission> {
  List<_CarbonData> data = [
    _CarbonData('Your Emmission', results['result']),
    _CarbonData('Global Traget \n You need to be here', 2.0)
  ];
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
                padding: const EdgeInsets.only(
                    top: 20, bottom: 70, left: 30, right: 30),
                child: SfCartesianChart(
                  palette: const [Color(0xFF28B67E)],
                  primaryXAxis: CategoryAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                  ),
                  // Chart title
                  title: ChartTitle(text: 'Compare your Co2 emission'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_CarbonData, String>>[
                    ColumnSeries<_CarbonData, String>(
                        animationDuration: 2500,
                        animationDelay: 2,
                        dataSource: data,
                        yValueMapper: (_CarbonData carbon, _) => carbon.tons,
                        xValueMapper: (_CarbonData carbon, _) => carbon.year,
                        name: 'Co2 tons / year',
                        // Enable data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true))
                  ],
                ),
              ),
            ),
    );
  }
}

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
              padding: const EdgeInsets.only(
                  top: 20, bottom: 70, left: 10, right: 10),
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
                      animationDuration: 2500,
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
          );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final dynamic y;
  final Color? color;
}

class _CarbonData {
  _CarbonData(this.year, this.tons);

  final String year;
  final double tons;
}
