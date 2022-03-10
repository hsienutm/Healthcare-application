import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/home.dart';

class ViewReminderRecord extends StatefulWidget {
  const ViewReminderRecord({Key? key}) : super(key: key);

  @override
  _ViewReminderRecordState createState() => _ViewReminderRecordState();
}

class _ViewReminderRecordState extends State<ViewReminderRecord> {
  final Stream<QuerySnapshot> reminder = FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('reminder')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BP Reminder Record"),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.cyan[100],
      body: StreamBuilder<QuerySnapshot>(
        stream: reminder,
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
                  '\nDate: $date\nLabel: ${data.docs[index]['label']}\nSound: ${data.docs[index]['sound']}\n',
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
