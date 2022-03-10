import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/add_period.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paragonhealth/Screen/view_symptoms.dart';
import 'package:table_calendar/table_calendar.dart';

class PeriodPage extends StatefulWidget {
  const PeriodPage({Key? key}) : super(key: key);

  @override
  _PeriodPageState createState() => _PeriodPageState();
}

Timestamp chosenDate = Timestamp.now();

class _PeriodPageState extends State<PeriodPage> {
  final Stream<QuerySnapshot> period = FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('period')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Cycle Tracking'),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.cyan[100],
      body: StreamBuilder<QuerySnapshot>(
          stream: period,
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
            final List<int> colorCodes = <int>[
              200,
              300,
              200,
              300,
              200,
              300,
              200,
              300
            ];
            CalendarFormat format = CalendarFormat.week;

            return ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        color: Colors.blue[colorCodes[index]],
                        child: TableCalendar(
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            formatButtonShowsNext: false,
                            rightChevronVisible: false,
                            leftChevronVisible: false,
                            titleTextStyle: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          daysOfWeekHeight: 30.0,
                          firstDay: DateTime.parse((data.docs[index]
                                  ['start_date']
                              .toDate()
                              .toString())),
                          rangeStartDay: DateTime.parse((data.docs[index]
                                  ['start_date']
                              .toDate()
                              .toString())),
                          lastDay: DateTime.parse((data.docs[index]['end_date']
                              .toDate()
                              .toString())),
                          rangeEndDay: DateTime.parse((data.docs[index]
                                  ['end_date']
                              .toDate()
                              .toString())),
                          focusedDay: DateTime.parse((data.docs[index]
                                  ['start_date']
                              .toDate()
                              .toString())),
                          calendarFormat: format,
                          daysOfWeekVisible: true,
                          calendarStyle: const CalendarStyle(
                            //rangeHighlightColor: Colors.amber,
                            rangeStartDecoration: BoxDecoration(
                                color: Colors.pink, shape: BoxShape.circle),
                            rangeEndDecoration: BoxDecoration(
                                color: Colors.pink, shape: BoxShape.circle),
                            isTodayHighlighted: false,
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        color: Colors.blue[colorCodes[index]],
                        child: Text(
                          '${data.docs[index]['days']} days period\n',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            //fontFamily: 'Raleway',
                            fontSize: 12,
                            //fontWeight: FontWeight.w900
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.blue[colorCodes[index]],
                        height: 30,
                        child: IconButton(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.topLeft,
                          iconSize: 30,
                          icon: const Icon(Icons.list_alt),
                          color: Colors.black,
                          onPressed: () {
                            chosenDate = data.docs[index]['start_date'];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ViewSymptoms()));
                          },
                        ),
                      )
                    ],
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPeriodPage()));
        },
        child: const Icon(Icons.add_rounded),
        backgroundColor: Colors.red[900],
      ),
    );
  }
}
