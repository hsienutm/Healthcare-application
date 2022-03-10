import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:paragonhealth/Screen/home.dart';

class AddAppointment extends StatefulWidget {
  const AddAppointment({Key? key}) : super(key: key);

  @override
  _AddAppointmentState createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  void clearText() {
    _dateController.clear();
    _timeController.clear();
    _doctorController.clear();
    _locationController.clear();
    _endTimeController.clear();
    _endDateController.clear();
  }

  String dateTimeString = '';
  String endDateTimeString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        title: const Text('Add Appointment'),
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
                    _timeController.text =
                        formattedTime; //set the value of text field.
                    dateTimeString += _timeController.text;
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
            TextFormField(
              controller: _doctorController,
              decoration: const InputDecoration(
                labelText: 'Doctor',
              ),
            ),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
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
                    .collection('appointment')
                    .add({
                  'start_date':
                      Timestamp.fromDate(DateTime.parse(dateTimeString)),
                  'end_date':
                      Timestamp.fromDate(DateTime.parse(endDateTimeString)),
                  'doctor': _doctorController.text,
                  'location': _locationController.text,
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
          ],
        ),
      ),
    );
  }
}
