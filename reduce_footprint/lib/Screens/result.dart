import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reduce_footprint/Screens/dashboard.dart';
import 'package:reduce_footprint/constants.dart';
import 'package:reduce_footprint/store.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    _CarbonData('Your Emmission', double.parse(results.data['result'])),
    _CarbonData('Global Traget', 2.0)
  ];
  final List<ChartData> chartData = [
    ChartData('Travel', results.data['travel']),
    ChartData('Diet', results.data['diet']),
    ChartData('Car Travel', results.data['carTravel']),
    ChartData('Fuel', results.data['fuel']),
    ChartData('Shopping', results.data['shopping']),
    ChartData('Home Size', results.data['homeSize']),
    ChartData('Members', results.data['homePeople']),
    ChartData('Pet', results.data['pet']),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: results == null
          ? const Center(
              child: Text('Something went wrong'),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Scaffold(
                body: Column(
                  children: [
                    //Initialize the chart widget
                    SfCartesianChart(
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
                        BarSeries<_CarbonData, String>(
                            dataSource: data,
                            xValueMapper: (_CarbonData carbon, _) =>
                                carbon.year,
                            yValueMapper: (_CarbonData carbon, _) =>
                                carbon.tons,
                            name: 'Co2',
                            // Enable data label
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true))
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        //Initialize the spark charts widget
                        child: SfCircularChart(
                          legend: Legend(isVisible: true),
                          series: <CircularSeries>[
                            // Render pie chart
                            PieSeries<ChartData, String>(
                              explode: true,
                              explodeAll: true,
                              legendIconType: LegendIconType.seriesType,
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              dataSource: chartData,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
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
