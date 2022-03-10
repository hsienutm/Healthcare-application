import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:paragonhealth/Model/bp.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ViewBPGraph extends StatefulWidget {
  const ViewBPGraph({Key? key}) : super(key: key);

  @override
  _ViewBPGraphState createState() => _ViewBPGraphState();
}

class _ViewBPGraphState extends State<ViewBPGraph> {
  final TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
  List<BPRecord> chartData = <BPRecord>[];

  final Stream<QuerySnapshot> bp = FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('bp')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        title: const Text('Blood Pressure Graph'),
      ),
      backgroundColor: Colors.cyan[100],
      body: StreamBuilder<QuerySnapshot>(
        stream: bp,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text("no value");
          }
          final data = snapshot.requireData;

          return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                var dt = DateTime.parse(
                    (data.docs[index]['date'].toDate().toString()));
                var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
                chartData.add(
                  BPRecord(
                      DateTime.parse(
                          (data.docs[index]['date'].toDate().toString())),
                      data.docs[index]['systolic'],
                      data.docs[index]['diastolic']),
                );
                chartData.sort((a, b) => a.date.compareTo(b.date));
                return SfCartesianChart(
                  primaryXAxis:
                      DateTimeAxis(name: "Date", dateFormat: DateFormat.MMMd()),
                  title: ChartTitle(text: 'BP Graph'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: _tooltipBehavior,
                  series: <ChartSeries>[
                    LineSeries<BPRecord, DateTime>(
                      name: 'Systolic Pressure',
                      dataSource: chartData,
                      xValueMapper: (BPRecord bpdata, _) => bpdata.date,
                      yValueMapper: (BPRecord bpdata, _) => bpdata.systolic,
                      //dataLabelSettings: const DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      markerSettings: const MarkerSettings(isVisible: true),
                      xAxisName: "Date",
                    ),
                    LineSeries<BPRecord, DateTime>(
                      name: 'Diastolic Pressure',
                      dataSource: chartData,
                      xValueMapper: (BPRecord bpdata, _) => bpdata.date,
                      yValueMapper: (BPRecord bpdata, _) => bpdata.diastolic,
                      //dataLabelSettings: const DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      markerSettings: const MarkerSettings(isVisible: true),
                      xAxisName: "Date",
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}

List<BPRecord> getChartData() {
  List<BPRecord> temp = [];
  FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('bp')
      .orderBy('date')
      .get()
      .then(
    (QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        var sys = doc['systolic'];
        var dia = doc['diastolic'];
        var date = DateTime.parse((doc['date'].toDate().toString()));

        print(sys);
        print(dia);
        print(date);

        temp.add(BPRecord(date, sys, dia));
      }
    },
  );
  return temp;
}
