import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddPeriodPage extends StatefulWidget {
  const AddPeriodPage({Key? key}) : super(key: key);

  @override
  _AddPeriodPageState createState() => _AddPeriodPageState();
}

class _AddPeriodPageState extends State<AddPeriodPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  final PageController controller = PageController();

  String startDateTimeString = '';
  String endDateTimeString = '';

  bool abd = false; //adbominal cramps
  bool acne = false; // acne
  bool app = false; //appetite changes
  bool breast = false; // breast pain
  bool fatigue = false; // fatigue
  bool mood = false; //mood changes
  bool night = false; //night sweats
  bool pelvic = false; //pelvic pain
  bool sleep = false; //sleep changes

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
        backgroundColor: Colors.blue[900],
        title: const Text("Add Period"),
      ),
      backgroundColor: Colors.cyan[100],
      body: PageView(
        controller: controller,
        children: <Widget>[
          Form(
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
                    labelText: 'Start Date of Period',
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
                    labelText: 'End Date of Period',
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
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "1 of 2",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  child: const Text('SAVE'),
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
                        .collection('period')
                        .add({
                      'start_date': Timestamp.fromDate(
                          DateTime.parse(startDateTimeString)),
                      'end_date':
                          Timestamp.fromDate(DateTime.parse(endDateTimeString)),
                      'days': DateTime.parse(endDateTimeString)
                              .difference(DateTime.parse(startDateTimeString))
                              .inDays +
                          1,
                    }).whenComplete(() =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.blueAccent,
                                content: Text('Record is successfully added!'),
                              ),
                            ));
                    clearText();
                  },
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
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
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "2 of 2",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
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
                      'date': Timestamp.fromDate(
                          DateTime.parse(startDateTimeString)),
                      'abdominal_cramp': abd,
                      'acne': acne,
                      'appetite_changes': app,
                      'breast_pain': breast,
                      'fatigue': fatigue,
                      'mood_changes': mood,
                      'night_sweats': night,
                      'pelvic_pain': pelvic,
                      'sleep_changes': sleep,
                    }).whenComplete(() =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.blueAccent,
                                content: Text('Record is successfully added!'),
                              ),
                            ));
                  },
                  child: const Text('SAVE'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
