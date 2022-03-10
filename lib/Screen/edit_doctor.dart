import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/doctor_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paragonhealth/Screen/home.dart';

class EditDoctor extends StatefulWidget {
  const EditDoctor({Key? key}) : super(key: key);

  @override
  _EditDoctorState createState() => _EditDoctorState();
}

class _EditDoctorState extends State<EditDoctor> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /*final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _controller = TextEditingController();*/

  /*void clearText() {
    _nameController.clear();
    _emailController.clear();
    _contactController.clear();
  }*/

  String dropdownValue = share;
  bool sharing = false;

  final Stream<QuerySnapshot> doctor = FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('doctor')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        title: const Text('Edit Doctor'),
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
              initialValue: docName,
              onChanged: (value) {
                docName = value;
              },
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              initialValue: docEmail,
              onChanged: (value) {
                docEmail = value;
              },
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              initialValue: docContact,
              onChanged: (value) {
                docContact = value;
              },
              decoration: const InputDecoration(
                labelText: 'Contact No',
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Sharing",
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
                  if (newValue == 'On') {
                    sharing = true;
                  }
                });
              },
              items: <String>['Off', 'On']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
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
                      content: Text('Editing your record...'),
                    ),
                  );
                }
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(docEmail)
                    .collection('patient')
                    .doc(registeredEmail)
                    .set({
                  'email': registeredEmail,
                  'sharing': sharing,
                });
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(registeredEmail)
                    .collection('doctor')
                    .doc(docEmail)
                    .set({
                  'name': docName,
                  'email': docEmail,
                  'contact': docContact,
                  'sharing': sharing,
                }).whenComplete(
                        () => ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.blueAccent,
                                content: Text('Record is successfully edited!'),
                              ),
                            ));
                //clearText();
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
          ],
        ),
      ),
    );
  }
}
