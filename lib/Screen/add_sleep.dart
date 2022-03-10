import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paragonhealth/Screen/home.dart';

class AddSleep extends StatefulWidget {
  const AddSleep({Key? key}) : super(key: key);

  @override
  State<AddSleep> createState() => _AddSleepState();
}

class _AddSleepState extends State<AddSleep> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  String startDateTimeString = '';
  String endDateTimeString = '';

  void clearText() {
    _startDateController.clear();
    _endDateController.clear();
    _startTimeController.clear();
    _endTimeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep'),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
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
              controller: _startDateController,
              decoration: const InputDecoration(
                labelText: 'Start Date',
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
                    _startDateController.text =
                        formattedDate; //set output date to TextField value.
                    startDateTimeString = _startDateController.text + " ";
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
            ),
            TextFormField(
              controller: _startTimeController,
              decoration: const InputDecoration(
                labelText: 'Start Time',
              ),
              readOnly: true,
              onTap: () async {
                String formattedTime = "";
                DatePicker.showTimePicker(context, showTitleActions: true,
                    onChanged: (date) {
                  print('change $date in time zone ' +
                      date.timeZoneOffset.inHours.toString());
                }, onConfirm: (date) {
                  print('confirm $date');
                  formattedTime = DateFormat('HH:mm:ss').format(date);
                  setState(() {
                    _startTimeController.text =
                        formattedTime; //set the value of text field.
                    startDateTimeString += _startTimeController.text;
                  });
                }, currentTime: DateTime.now());
              },
            ),
            TextFormField(
              controller: _endDateController,
              decoration: const InputDecoration(
                labelText: 'End Date',
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
                    _endDateController.text =
                        formattedDate; //set output date to TextField value.
                    endDateTimeString = _endDateController.text + " ";
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
            ),
            TextFormField(
              controller: _endTimeController,
              decoration: const InputDecoration(
                labelText: 'End Time',
              ),
              readOnly: true,
              onTap: () async {
                String formattedTime = "";
                DatePicker.showTimePicker(context, showTitleActions: true,
                    onChanged: (date) {
                  print('change $date in time zone ' +
                      date.timeZoneOffset.inHours.toString());
                }, onConfirm: (date) {
                  print('confirm $date');
                  formattedTime = DateFormat('HH:mm:ss').format(date);
                  setState(() {
                    _endTimeController.text =
                        formattedTime; //set the value of text field.
                    endDateTimeString += _endTimeController.text;
                  });
                }, currentTime: DateTime.now());
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Submitting your record...'),
                    ),
                  );

                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(registeredEmail)
                      .collection('sleep')
                      .add(
                    {
                      'start_time': Timestamp.fromDate(
                          DateTime.parse(startDateTimeString)),
                      'end_time':
                          Timestamp.fromDate(DateTime.parse(endDateTimeString)),
                      'hours': DateTime.parse(endDateTimeString)
                          .difference(DateTime.parse(startDateTimeString))
                          .inHours,
                    },
                  ).whenComplete(() =>
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.blueAccent,
                              content: Text('Record is successfully added!'),
                            ),
                          ));
                  clearText();
                }
              },
              child: const Text('SAVE'),
            ),
            const SizedBox(height: 30),
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
