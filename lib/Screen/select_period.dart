import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/add_symptoms.dart';
import 'package:paragonhealth/Screen/add_period.dart';

class SelectPeriod extends StatefulWidget {
  const SelectPeriod({Key? key}) : super(key: key);

  @override
  _SelectPeriodState createState() => _SelectPeriodState();
}

class _SelectPeriodState extends State<SelectPeriod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cycle Tracking'),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.cyan[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddPeriodPage()),
                );
              },
              child: const Text('Add Period',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.white54,
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddSymptoms()),
                );
              },
              child: const Text('Add Symptomps',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
