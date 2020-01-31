import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test FL Chart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Test FL chart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<LineChartBarData> _listDataSnow = List<LineChartBarData>();
  List<LineChartBarData> _listDataTemp = List<LineChartBarData>();
  @override
  void initState() {
    _initData();
    super.initState();
  }

  _initData() {
    var random = Random();
    var dataTemp = List<FlSpot>();
    var dataSnow = List<FlSpot>();
    _listDataTemp.clear();
    _listDataSnow.clear();
    for (int i = 0; i < 10; i++) {
      double val = (random.nextDouble() * 64) - 30;
      dataTemp.add(FlSpot(i.toDouble(), val));
    }
    for (int i = 0; i < 10; i++) {
      double val = (random.nextDouble() * 150);
      dataSnow.add(FlSpot(i.toDouble(), val));
    }

    _listDataTemp.add(LineChartBarData(
      spots: dataTemp,
      isCurved: true,
      colors: [
        Colors.redAccent,
      ],
    ));
    _listDataSnow.add(LineChartBarData(
      spots: dataSnow,
      isCurved: true,
      colors: [
        Colors.blue,
      ],
      dotData: FlDotData(
        show: false,
      ),
    ));
  }

  _refresh() {
    setState(() {
      _initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: media.size.height / 2,
              maxWidth: media.size.width,
            ),
            child: LineChart(
              LineChartData(
                lineBarsData: _listDataTemp,
                gridData: const FlGridData(
                  horizontalInterval: 5,
                  show: true,
                ),
                titlesData: FlTitlesData(
                  bottomTitles: SideTitles(
                    showTitles: true,
                    margin: 10,
                    getTitles: (value) {
                      return value.toInt().toString();
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    interval: 10,
                    margin: 8,
                    getTitles: (value) {
                      return value.toInt().toString();
                    },
                    reservedSize: 30,
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black87,
                      width: 2,
                    ),
                    left: BorderSide(
                      color: Colors.black87,
                      width: 2,
                    ),
                    right: BorderSide(
                      color: Colors.transparent,
                    ),
                    top: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                clipToBorder: true,
              ),
              swapAnimationDuration: Duration(milliseconds: 250),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: media.size.height / 2,
              maxWidth: media.size.width,
            ),
            child: LineChart(
              LineChartData(
                lineBarsData: _listDataSnow,
                maxY: 160.0,
                minY: 0,
                axisTitleData: FlAxisTitleData(
                  show: true,
                ),
                gridData: const FlGridData(
                  horizontalInterval: 10,
                  show: true,
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black87,
                      width: 2,
                    ),
                    left: BorderSide(
                      color: Colors.black87,
                      width: 2,
                    ),
                    right: BorderSide(
                      color: Colors.transparent,
                    ),
                    top: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: SideTitles(
                    showTitles: true,
                    margin: 10,
                    getTitles: (value) {
                      return value.toInt().toString();
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    interval: 20,
                    margin: 2,
                    reservedSize: 36,
                  ),
                ),
              ),
              swapAnimationDuration: Duration(milliseconds: 750),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
