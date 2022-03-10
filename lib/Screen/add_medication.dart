import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paragonhealth/Screen/view_med_record.dart';
import 'package:paragonhealth/Screen/home.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({Key? key}) : super(key: key);

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _medController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  String dateTimeString = '';

  void clearText() {
    _dateController.clear();
    _timeController.clear();
    _medController.clear();
    _doseController.clear();
    _reasonController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        title: const Text('Medication'),
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
              controller: _medController,
              decoration: const InputDecoration(
                labelText: 'Medicine Name',
              ),
            ),
            TextFormField(
              controller: _doseController,
              decoration: const InputDecoration(
                labelText: 'Dose (in mg)',
              ),
            ),
            TextFormField(
              controller: _reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason',
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
                    .collection('medication')
                    .add({
                  'date': Timestamp.fromDate(DateTime.parse(dateTimeString)),
                  'dose': int.parse(_doseController.text),
                  'medicine': _medController.text,
                  'reason': _reasonController.text,
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewMedRecord()));
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
