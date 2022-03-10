import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'home.dart';

class AddSymptoms extends StatefulWidget {
  const AddSymptoms({Key? key}) : super(key: key);

  @override
  _AddSymptoms createState() => _AddSymptoms();
}

class _AddSymptoms extends State<AddSymptoms> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool abd = false; //adbominal cramps
  bool acne = false; // acne
  bool app = false; //appetite changes
  bool breast = false; // breast pain
  bool fatigue = false; // fatigue
  bool mood = false; //mood changes
  bool night = false; //night sweats
  bool pelvic = false; //pelvic pain
  bool sleep = false; //sleep changes
  String dateTimeString = '';

  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        title: const Text('Symptomps'),
      ),
      backgroundColor: Colors.cyan[100],
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
            ),
            TextFormField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Select Date',
              ),
              readOnly: true,
              onTap: () async {
                String formattedDate = "";
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2000, 1, 1),
                    maxTime: DateTime(2101, 1, 1), onChanged: (date) {
                  print('change $date');
                }, onConfirm: (date) {
                  print('confirm $date');
                  formattedDate = DateFormat('yyyy-MM-dd').format(date);
                  setState(() {
                    _dateController.text =
                        formattedDate; //set the value of text field.
                    dateTimeString = _dateController.text;
                  });
                }, currentTime: DateTime.now());
              },
            ),
            CheckboxListTile(
              value: abd,
              onChanged: (val) {
                setState(() {
                  abd = val!;
                });
              },
              activeColor: Colors.blueAccent,
              title: const Text("Abdominal Cramps"),
            ),
            CheckboxListTile(
              value: acne,
              onChanged: (val) {
                setState(() {
                  acne = val!;
                });
              },
              activeColor: Colors.blueAccent,
              title: const Text("Acne"),
            ),
            CheckboxListTile(
              value: app,
              onChanged: (val) {
                setState(() {
                  app = val!;
                });
              },
              activeColor: Colors.blueAccent,
              title: const Text("Appetite Changes"),
            ),
            CheckboxListTile(
              value: breast,
              onChanged: (val) {
                setState(() {
                  breast = val!;
                });
              },
              activeColor: Colors.blueAccent,
              title: const Text("Breast Pain"),
            ),
            CheckboxListTile(
              value: fatigue,
              onChanged: (val) {
                setState(() {
                  fatigue = val!;
                });
              },
              activeColor: Colors.blueAccent,
              title: const Text("Fatigue"),
            ),
            CheckboxListTile(
              value: mood,
              onChanged: (val) {
                setState(() {
                  mood = val!;
                });
              },
              activeColor: Colors.blueAccent,
              title: const Text("Mood Changes"),
            ),
            CheckboxListTile(
              value: night,
              onChanged: (val) {
                setState(() {
                  night = val!;
                });
              },
              activeColor: Colors.blueAccent,
              title: const Text("Night Sweats"),
            ),
            CheckboxListTile(
              value: pelvic,
              onChanged: (val) {
                setState(() {
                  pelvic = val!;
                });
              },
              activeColor: Colors.blueAccent,
              title: const Text("Pelvic Pain"),
            ),
            CheckboxListTile(
              value: sleep,
              onChanged: (val) {
                setState(() {
                  sleep = val!;
                });
              },
              activeColor: Colors.blueAccent,
              title: const Text("Sleep Changes"),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.blueAccent,
                      content: Text('Submitting your record...'),
                    ),
                  );
                }

                FirebaseFirestore.instance
                    .collection('users')
                    .doc(registeredEmail)
                    .collection('period-symptoms')
                    .add({
                  'date': Timestamp.fromDate(DateTime.parse(dateTimeString)),
                  'abdominal_cramp': abd,
                  'acne': acne,
                  'appetite_changes': app,
                  'breast_pain': breast,
                  'fatigue': fatigue,
                  'mood_changes': mood,
                  'night_sweats': night,
                  'pelvic_pain': pelvic,
                  'sleep_changes': sleep,
                }).whenComplete(
                        () => ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.blueAccent,
                                content: Text('Record is successfully added!'),
                              ),
                            ));
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
              onPressed: () {},
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
