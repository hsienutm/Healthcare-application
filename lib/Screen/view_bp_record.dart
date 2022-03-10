import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paragonhealth/Screen/home.dart';

class ViewBPRecord extends StatefulWidget {
  const ViewBPRecord({Key? key}) : super(key: key);

  @override
  _ViewBPRecordState createState() => _ViewBPRecordState();
}

final Stream<QuerySnapshot> bp = FirebaseFirestore.instance
    .collection('users')
    .doc(registeredEmail)
    .collection('bp')
    .snapshots();

class _ViewBPRecordState extends State<ViewBPRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BP Record"),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
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

                return Text(
                  '\nDate: $date\nSystolic: ${data.docs[index]['systolic']}\nDiastolic: ${data.docs[index]['diastolic']}\n',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                );
              });
        },
      ),
    );
  }
}
