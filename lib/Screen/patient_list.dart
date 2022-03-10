import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:paragonhealth/Screen/view_patient_record.dart';

class DocViewPatient extends StatefulWidget {
  const DocViewPatient({Key? key}) : super(key: key);

  @override
  _DocViewPatientState createState() => _DocViewPatientState();
}

dynamic patientEmail;

class _DocViewPatientState extends State<DocViewPatient> {
  final Stream<QuerySnapshot> patient = FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('patient')
      .snapshots();

  void checkDoc() {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(registeredEmail)
        .collection('patient');
    bool empty = ref.snapshots().isEmpty as bool;
    if (empty) {
      isDoctor = false;
    } else {
      isDoctor = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient List"),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.cyan[100],
      body: isDoctor
          ? const Center(
              child: Text("You're not a doctor.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: patient,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Text("There's currently no record.",
                      textAlign: TextAlign.center);
                }
                final data = snapshot.requireData;

                return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(10.0),
                        color: Colors.lightBlue.shade200,
                        elevation: 1.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                'Patient ${index + 1} \nEmail: ${data.docs[index]['email']}',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.view_list_rounded,
                                      size: 30.0,
                                      color: Colors.brown[900],
                                    ),
                                    onPressed: () async {
                                      patientEmail = data.docs[index]['email'];
                                      print(patientEmail);
                                      if (data.docs[index]['sharing']) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ViewPatientRecord(),
                                          ),
                                        );
                                      } else {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: const Text('Oops'),
                                                  content: const Text(
                                                      'Data sharing is not turned on.'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context, 'OK'),
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                ));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
    );
  }
}
