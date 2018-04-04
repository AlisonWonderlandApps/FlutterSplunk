import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_charts/flutter_charts.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Station Performance Chart',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new AnalyticsPage(title: 'Station Performance Chart'),
    );
  }
}

class AnalyticsPage extends StatefulWidget {
  AnalyticsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AnalyticsPageState createState() => new _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {

  LineChartOptions _lineChartOptions;
  ChartOptions _verticalBarChartOptions;

  ChartData _chartData;

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
      [1.0,2.0,3.0,4.0,5.0 ],
    ];
    _chartData.xLabels =  ["This Week", "Last Week", "-2 Weeks", "-3 Weeks", "-4 Weeks"];
    _chartData.dataRowsColors = [Colors.amber];
    // Note: ChartOptions.useUserProvidedYLabels default is still used (false);
  }

  void _chartStateChanger() {
    setState(() {
    });
  }

  @override
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
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
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
    );
  }
}
