import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/add_bp_reminder.dart';
import 'package:paragonhealth/Screen/add_bp.dart';

class SelectRecordOrReminder extends StatefulWidget {
  const SelectRecordOrReminder({Key? key}) : super(key: key);

  @override
  _SelectRecordOrReminderState createState() => _SelectRecordOrReminderState();
}

class _SelectRecordOrReminderState extends State<SelectRecordOrReminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Pressure'),
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
                  MaterialPageRoute(builder: (context) => const SaveBPRecord()),
                );
              },
              child: const Text('Add BP Record',
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
                  MaterialPageRoute(builder: (context) => const AddReminder()),
                );
              },
              child: const Text('Add Reminder',
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
