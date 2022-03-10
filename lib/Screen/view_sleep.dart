import 'package:flutter/material.dart';
import 'package:time_chart/time_chart.dart';
import 'package:paragonhealth/Screen/sleep.dart';

class ViewSleepPage extends StatefulWidget {
  const ViewSleepPage({Key? key}) : super(key: key);

  @override
  State<ViewSleepPage> createState() => _ViewSleepPageState();
}

class _ViewSleepPageState extends State<ViewSleepPage> {
  displayTimeChart() {
    if (sleepData.isNotEmpty) {
      sleepData.sort((a, b) => b.start.compareTo(a.start));
      return TimeChart(data: sleepData, viewMode: ViewMode.weekly);
    } else {
      return const Text("There's no record yet.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep'),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.cyan[100],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              child: const Text(
                "Sleep Record",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: displayTimeChart(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
