import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paragonhealth/Screen/add_sleep.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:paragonhealth/Screen/view_sleep.dart';
import 'package:intl/intl.dart';

late List<DateTimeRange> sleepData = [];

class SleepPage extends StatefulWidget {
  const SleepPage({Key? key}) : super(key: key);

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  final Stream<QuerySnapshot> sleep = FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('sleep')
      .snapshots();

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
            Container(
              margin: const EdgeInsets.all(20.0),
              width: 500,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: StreamBuilder<QuerySnapshot>(
                  stream: sleep,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot,
                  ) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong...');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading...');
                    }

                    final data = snapshot.requireData;

                    return ListView.builder(
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          var dt1 = DateTime.parse((data.docs[index]
                                  ['start_time']
                              .toDate()
                              .toString()));
                          var date1 =
                              DateFormat('MM/dd/yyyy, hh:mm a').format(dt1);
                          var dt2 = DateTime.parse((data.docs[index]['end_time']
                              .toDate()
                              .toString()));
                          var date2 =
                              DateFormat('MM/dd/yyyy, hh:mm a').format(dt2);
                          sleepData.add(DateTimeRange(
                              start: DateTime.parse((data.docs[index]
                                      ['start_time']
                                  .toDate()
                                  .toString())),
                              end: DateTime.parse((data.docs[index]['end_time']
                                  .toDate()
                                  .toString()))));
                          return Text(
                            'In Bed Start: $date1\n In Bed End: $date2 Total: ${data.docs[index]['hours']} hours\n',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          );
                        });
                  }),
            ),
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.cyan.shade900),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const ViewSleepPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            'View Time \nChart',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddSleep()));
        },
        child: const Icon(Icons.add_rounded),
        backgroundColor: Colors.red[900],
      ),
    );
  }
}
