import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:paragonhealth/Screen/view_bp_record.dart';
import 'package:paragonhealth/Screen/view_bp_graph.dart';

class SaveBPRecord extends StatefulWidget {
  const SaveBPRecord({Key? key}) : super(key: key);

  @override
  _SaveBPRecordScreen createState() => _SaveBPRecordScreen();
}

class _SaveBPRecordScreen extends State<SaveBPRecord> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _systolicController = TextEditingController();
  final TextEditingController _diastolicController = TextEditingController();

  void clearText() {
    _dateController.clear();
    _timeController.clear();
    _systolicController.clear();
    _diastolicController.clear();
  }

  String dateTimeString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        title: const Text('Blood Pressure'),
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
                labelText: 'Date',
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
                        formattedDate; //set output date to TextField value.
                    dateTimeString = _dateController.text + " ";
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
            ),
            TextFormField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'Time',
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
                    _timeController.text =
                        formattedTime; //set the value of text field.
                    dateTimeString += _timeController.text;
                  });
                }, currentTime: DateTime.now());
              },
            ),
            TextFormField(
              controller: _systolicController,
              decoration: const InputDecoration(
                labelText: 'Systolic Pressure',
              ),
            ),
            TextFormField(
              controller: _diastolicController,
              decoration: const InputDecoration(
                labelText: 'Diastolic Pressure',
              ),
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
                      backgroundColor: Colors.blueAccent,
                      content: Text('Submitting your record...'),
                    ),
                  );
                }

                FirebaseFirestore.instance
                    .collection('users')
                    .doc(registeredEmail)
                    .collection('bp')
                    .add({
                  'date': Timestamp.fromDate(DateTime.parse(dateTimeString)),
                  'systolic': int.parse(_systolicController.text),
                  'diastolic': int.parse(_diastolicController.text),
                }).whenComplete(
                        () => ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.blueAccent,
                                content: Text('Record is successfully added!'),
                              ),
                            ));
                clearText();
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
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.cyan.shade900.withOpacity(0.2),
                  blurRadius: 2,
                  offset: const Offset(10, 10),
                )
              ]),
              constraints:
                  const BoxConstraints(maxWidth: 200.0, minHeight: 80.0),
              margin: const EdgeInsets.all(10),
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
                              const ViewBPRecord()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'View Previous\nBP Record',
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
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.cyan.shade900.withOpacity(0.2),
                  blurRadius: 2,
                  offset: const Offset(10, 10),
                )
              ]),
              constraints:
                  const BoxConstraints(maxWidth: 200.0, minHeight: 80.0),
              margin: const EdgeInsets.all(10),
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
                              const ViewBPGraph()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'View BP Graph',
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
          ],
        ),
      ),
    );
  }
}
