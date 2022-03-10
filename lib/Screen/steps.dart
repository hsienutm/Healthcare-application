// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/add_steps.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DailyStepsPage extends StatefulWidget {
  const DailyStepsPage({Key? key}) : super(key: key);

  @override
  _DailyStepsPageState createState() => _DailyStepsPageState();
}

class _DailyStepsPageState extends State<DailyStepsPage> {
  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  /*@override
  void initState() {
    //TODO: implement initState
    super.initState();
  }*/

  //final Stream<QuerySnapshot> steps = FirebaseFirestore.instance.collection('users').snapshots();

  final Stream<QuerySnapshot> steps = FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('steps')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Steps'),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.cyan[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TableCalendar(
              daysOfWeekHeight: 30.0,
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
              focusedDay: DateTime.now(),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              daysOfWeekVisible: true,
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
                print(focusedDay);
              },
              calendarStyle: const CalendarStyle(
                  isTodayHighlighted: true,
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  )
                  //selectedTextStyle: TextStyle(color: Colors.white),
                  ),
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },
            ),
            const SizedBox(height: 20),
            Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: steps,
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
                          return Text(
                            '${data.docs[index]['counts']} steps \n ${data.docs[index]['calories']} calories \n',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          );
                        });
                  }),
              alignment: Alignment.center,
              width: 300,
              height: 400,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                border: Border.all(
                  color: Colors.teal,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddSteps()));
        },
        child: const Icon(Icons.add_rounded),
        backgroundColor: Colors.red[900],
      ),
    );
  }
}
