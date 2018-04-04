import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_charts/flutter_charts.dart';
import "dart:async";
import "dart:convert";
import "dart:core";
import 'package:http/http.dart' as http;

class AnalyticsPage extends StatefulWidget {

  @override
  _AnalyticsPageState createState() => new _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  List data;

  LineChartOptions _lineChartOptions;
  ChartOptions _verticalBarChartOptions;

  ChartData _chartData;

  Future<String> getData() async {
    // http.Response
    var response = await http.get(
        Uri.encodeFull("https://api.myjson.com/bins/1dlmxv"),
        headers: {
          //"key": "apikey",
          "Accept": "application.json",
        }
    );

    print(response.body);

    this.setState(() {
      data = JSON.decode(response.body);
    });

    print(data[0]['processor']);
    return("success");
  }


  _AnalyticsPageState() {

    // defineOptionsAndData();

  }

  /* void defineOptionsAndData() {
    _lineChartOptions = new LineChartOptions();
    _verticalBarChartOptions = new VerticalBarChartOptions();
    _chartData = new RandomChartData(useUserProvidedYLabels: _lineChartOptions.useUserProvidedYLabels);
  } */

  void defineOptionsAndData() {
    _lineChartOptions = new LineChartOptions();
    _verticalBarChartOptions = new VerticalBarChartOptions();
    _chartData = new ChartData();
    _chartData.dataRowsLegends = [
      "Failures"];
    _chartData.dataRows = [
      [double.parse(data[0]['count']),double.parse(data[1]['count']),double.parse(data[2]['count']),double.parse(data[3]['count']),double.parse(data[4]['count'])
   ], ];
    _chartData.xLabels =  [data[0]['processor'],data[1]['processor'],data[2]['processor'],data[3]['processor'],data[4]['processor']];
//    _chartData.xLabels =  ['hello','hello1','hello2','hello3','hello4'];
    _chartData.dataRowsColors = [Colors.amber];
    // Note: ChartOptions.useUserProvidedYLabels default is still used (false);
  }

  void _chartStateChanger() {
    setState(() {
    });
  }

  @override
  void initState() {
    this.getData();
  }
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    ui.Size windowLogicalSize = mediaQueryData.size;
    double logicalToDevicePixelSize = mediaQueryData.devicePixelRatio;
    double fontScale = mediaQueryData.textScaleFactor;

    final ui.Size chartLogicalSize =
    new Size(windowLogicalSize.width, windowLogicalSize.height / 2);

    print(" ### Size: ui.window.physicalSize=${ui.window.physicalSize}, "
        "windowLogicalSize = mediaQueryData.size = $windowLogicalSize,"
        "chartLogicalSize=$chartLogicalSize");

    defineOptionsAndData();

    LineChart lineChart = new LineChart(
      painter: new LineChartPainter(),
      layouter: new LineChartLayouter(
          chartData: _chartData,
          chartOptions: _lineChartOptions),
    );

    VerticalBarChart verticalBarChart = new VerticalBarChart(
      painter: new VerticalBarChartPainter(),
      layouter: new VerticalBarChartLayouter(
          chartData: _chartData,
          chartOptions: _verticalBarChartOptions),
    );

    return new Scaffold(
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded( // expansion inside Column pulls contents |
                child:
                new Row(
                  // this stretch carries | expansion to <--> Expanded children
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    new Expanded(
                      child:  verticalBarChart,
                    ),
                  ],
                ), //
              ), // Column -> Expanded
            ],
          ),
        ),
      ),
    );
  }
}
