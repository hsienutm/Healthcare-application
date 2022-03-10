import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/appointment.dart';
import 'package:paragonhealth/Screen/period.dart';
import 'package:paragonhealth/Screen/sleep.dart';
import 'package:paragonhealth/Screen/steps.dart';
import 'package:paragonhealth/Screen/view_med_record.dart';
import 'package:paragonhealth/Screen/blood_pressure.dart';
import 'package:paragonhealth/Screen/select_doc_fam.dart';
import 'package:paragonhealth/Screen/glucose.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.indigo[50],
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: const Text('Appoinment'),
              trailing: const Icon(Icons.keyboard_arrow_right_sharp),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AppointmentPage(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Blood Pressure'),
              trailing: const Icon(Icons.keyboard_arrow_right_sharp),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BloodPressurePage(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              //tileColor: Colors.lightBlue[100],
              title: const Text('Blood Glucose'),
              trailing: const Icon(Icons.keyboard_arrow_right_sharp),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GlucosePage(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Cycle Tracking'),
              trailing: const Icon(Icons.keyboard_arrow_right_sharp),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PeriodPage(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Medication'),
              trailing: const Icon(Icons.keyboard_arrow_right_sharp),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewMedRecord(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Sleep'),
              trailing: const Icon(Icons.keyboard_arrow_right_sharp),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SleepPage(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Steps'),
              trailing: const Icon(Icons.keyboard_arrow_right_sharp),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DailyStepsPage(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Others'),
              trailing: const Icon(Icons.keyboard_arrow_right_sharp),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectDocOrFam(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
