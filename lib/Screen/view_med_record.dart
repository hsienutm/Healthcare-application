import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paragonhealth/Screen/add_medication.dart';
import 'package:paragonhealth/Screen/home.dart';

class ViewMedRecord extends StatelessWidget {
  ViewMedRecord({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> med = FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('medication')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Medication'),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.cyan[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Medication Record",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            margin: const EdgeInsets.all(20.0),
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: BorderRadius.circular(20),
            ),
            child: StreamBuilder<QuerySnapshot>(
                stream: med,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong...');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading...');
                  }

                  final data = snapshot.requireData;

                  return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return Text(
                            '\n  Medicine name: ${data.docs[index]['medicine']}\n  Reason: ${data.docs[index]['reason']}\n  Dosage: ${data.docs[index]['dose']} mg\n',
                            style: const TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                fontSize: 12));
                      });
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MedicationPage()));
        },
        child: const Icon(Icons.add_rounded),
        backgroundColor: Colors.red[900],
      ),
    );
  }
}
