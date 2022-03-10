import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/select_bp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paragonhealth/Screen/view_bp_reminder.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({Key? key}) : super(key: key);

  @override
  _AddReminderState createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String dropdownValue = "Radar";
  String dateTimeString = '';

  void clearText() {
    _dateController.clear();
    _timeController.clear();
    _labelController.clear();
  }

  final CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('reminder');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Blood Pressure'),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.cyan[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextFormField(
              controller: _dateController,
              decoration: const InputDecoration(
                hintText: 'Enter date',
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
            const SizedBox(height: 10),
            TextFormField(
              controller: _timeController,
              decoration: const InputDecoration(
                hintText: 'Enter time',
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
            const SizedBox(height: 10),
            TextFormField(
              controller: _labelController,
              decoration: const InputDecoration(
                hintText: 'Enter label',
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Choose Sound",
                textAlign: TextAlign.left,
                style: TextStyle(color: Color(0xFF616161)),
              ),
            ),
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down_circle),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 1,
                color: const Color(0xFF616161),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Radar', 'Opening', 'Playtime', 'Signal']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                ref.add({
                  'date': Timestamp.fromDate(DateTime.parse(dateTimeString)),
                  'label': _labelController.text,
                  'sound': dropdownValue,
                }).whenComplete(
                    () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.blueAccent,
                            content: Text('Record is successfully added!'),
                          ),
                        ));
                clearText();
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectRecordOrReminder()),
                );
              },
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
                  const BoxConstraints(maxWidth: 240.0, minHeight: 80.0),
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
                              const ViewReminderRecord()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'View Previous\nReminder Record',
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
