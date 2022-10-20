import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nicotine/Constant.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyHomeScreen extends StatefulWidget {
  final int waterCount;
  final int stepsCount;
  final int foodCount;
  final int cigrettes;
  final int herbalMix;
  const MyHomeScreen(
      {Key? key,
      required this.waterCount,
      required this.stepsCount,
      required this.foodCount,
      required this.cigrettes,
      required this.herbalMix})
      : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  late List<ChartData> data;
  late List<ChartData> data2;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    super.initState();
    data = [
      ChartData('Water', 216 / 270 * 100),
      ChartData('Food', 42144 / 52680 * 100),
      ChartData('Steps Walked', 300000 / 330000 * 100),
      ChartData('Cigrettes', 0),
      ChartData('Herbal Mix', 160 / 200 * 100)
    ];
    data2 = [
      ChartData('Water', widget.waterCount.toDouble() / 270 * 100),
      ChartData('Food', widget.foodCount.toDouble() / 52680 * 100),
      ChartData('Steps Walked', widget.stepsCount.toDouble() / 300000 * 100),
      ChartData('Cigrettes', widget.cigrettes.toDouble()),
      ChartData('Herbal Mix', widget.herbalMix.toDouble() / 200 * 100)
    ];
    _tooltip = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      "Note: This graph is shows comparison of your consumption percentage and healthy consumption percentage of all the activity elements",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      color: kLightColor,
                      height: 25.h,
                      child: SfCartesianChart(
                          plotAreaBorderColor: Colors.white,
                          borderColor: Colors.white,
                          backgroundColor: Colors.white,
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(
                              minimum: 0, maximum: 110, interval: 10),
                          tooltipBehavior: _tooltip,
                          series: <ChartSeries<ChartData, String>>[
                            BarSeries<ChartData, String>(
                                dataSource: data,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                name: 'Healthy Consumption',
                                color: Colors.yellow),
                            BarSeries<ChartData, String>(
                                dataSource: data2,
                                xValueMapper: (ChartData data2, _) => data2.x,
                                yValueMapper: (ChartData data2, _) => data2.y,
                                name: 'Your Consumption',
                                color: Color.fromRGBO(8, 142, 255, 1))
                          ]),
                    ),
                    Container(
                      // height: 5.h,
                      width: 90.w,
                      color: Colors.white,
                      // color: Colors.black26,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 1.w,
                          ),
                          Container(
                            height: 2.h,
                            width: 4.w,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Text(
                            " Your Consumption",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Container(
                            height: 2.h,
                            width: 4.w,
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Text(
                            " Healthy Consumption",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
