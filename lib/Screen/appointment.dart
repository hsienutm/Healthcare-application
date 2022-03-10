import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paragonhealth/Screen/add_appointment.dart';
import 'package:paragonhealth/Screen/add_appointment_via_calendar.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

DateTime? selectedDate;

class _AppointmentPageState extends State<AppointmentPage> {
  List<Appointment> appointment = <Appointment>[];
  final PageController controller = PageController();

  final Stream<QuerySnapshot> medAppointment = FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('appointment')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        title: const Text('Appointment'),
      ),
      backgroundColor: Colors.cyan[100],
      body: PageView(
        controller: controller,
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: medAppointment,
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
                      (data.docs[index]['start_date'].toDate().toString()));
                  var date1 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt1);
                  var dt2 = DateTime.parse(
                      (data.docs[index]['end_date'].toDate().toString()));
                  var date2 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt2);

                  appointment.add(Appointment("Medical Appointment", dt1, dt2,
                      Colors.deepPurple, false));

                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade200,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      'Start: $date1\nEnd: $date2\nDoctor: ${data.docs[index]['doctor']}\nLocation: ${data.docs[index]['location']}\n',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
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
          Center(
            child: SfCalendar(
              view: CalendarView.month,
              dataSource: AppointmentDataSource(appointment),
              monthViewSettings: const MonthViewSettings(
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment),
              onTap: (CalendarTapDetails calendarTapDetails) {
                selectedDate = calendarTapDetails.date;
                print('$selectedDate');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AddAppointmentInCalendar()));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddAppointment()));
        },
        child: const Icon(Icons.add_rounded),
        backgroundColor: Colors.red[900],
      ),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Appointment {
  Appointment(
      this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
