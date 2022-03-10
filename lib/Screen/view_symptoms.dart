import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:paragonhealth/Screen/period.dart';

class ViewSymptoms extends StatefulWidget {
  const ViewSymptoms({Key? key}) : super(key: key);

  @override
  _ViewSymptomsState createState() => _ViewSymptomsState();
}

class _ViewSymptomsState extends State<ViewSymptoms> {
  final Stream<QuerySnapshot> symptoms = FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('period-symptoms')
      .where("date == $chosenDate")
      .snapshots();

  bool abd = false; //adbominal cramps
  bool acne = false; // acne
  bool app = false; //appetite changes
  bool breast = false; // breast pain
  bool fatigue = false; // fatigue
  bool mood = false; //mood changes
  bool night = false; //night sweats
  bool pelvic = false; //pelvic pain
  bool sleep = false; //sleep changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Symptoms"),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.cyan[100],
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(registeredEmail)
            .collection('period-symptoms')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text("There's currently no data.");
          }
          final data = snapshot.requireData;

          return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                List<String> symp = <String>[];

                abd = data.docs[index]["abdominal_cramp"]; //adbominal cramps
                acne = data.docs[index]["acne"]; // acne
                app = data.docs[index]["appetite_changes"]; //appetite changes
                breast = data.docs[index]["breast_pain"]; // breast pain
                fatigue = data.docs[index]["fatigue"]; // fatigue
                mood = data.docs[index]["mood_changes"]; //mood changes
                night = data.docs[index]["night_sweats"]; //night sweats
                pelvic = data.docs[index]["pelvic_pain"]; //pelvic pain
                sleep = data.docs[index]["sleep_changes"]; //sleep changes

                if (abd) {
                  symp.add("Abdominal Cramps");
                }

                if (acne) {
                  symp.add("Acne");
                }
                if (app) {
                  symp.add("Appetite Changes");
                }

                if (breast) {
                  symp.add("Breast Pain");
                }

                if (fatigue) {
                  symp.add("Fatigue");
                }
                if (mood) {
                  symp.add("Mood Changes");
                }
                if (night) {
                  symp.add("Night Sweats");
                }

                if (pelvic) {
                  symp.add("Pelvic Pain");
                }
                if (sleep) {
                  symp.add("Sleep Changes");
                }

                return AlertDialog(
                  backgroundColor: Colors.purple.shade50,
                  title: const Text('Logged Symptoms'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('$symp'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Okay'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
