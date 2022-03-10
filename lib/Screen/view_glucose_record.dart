import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ViewGlucoseRecord extends StatefulWidget {
  const ViewGlucoseRecord({Key? key}) : super(key: key);

  @override
  _ViewGlucoseRecordState createState() => _ViewGlucoseRecordState();
}

class _ViewGlucoseRecordState extends State<ViewGlucoseRecord> {
  List<Appointment> appointment = <Appointment>[];
  final PageController controller = PageController();

  final Stream<QuerySnapshot> glucose = FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('glucose')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        title: const Text('Glucose Reocrd'),
      ),
      backgroundColor: Colors.cyan[100],
      body: PageView(
        controller: controller,
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: glucose,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Text("no value");
              }
              final data = snapshot.requireData;

              return GridView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  var dt1 = DateTime.parse(
                      (data.docs[index]['date'].toDate().toString()));
                  var date1 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt1);

                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.pinkAccent.shade100,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      'Date: \n$date1\n\nGlucose level: \n${data.docs[index]['glucose']}mg/dL',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  //childAspectRatio: 3 / 2,
                  //crossAxisSpacing: 20,
                  //mainAxisSpacing: 20,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
