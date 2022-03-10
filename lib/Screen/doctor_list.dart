import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/add_doctor.dart';
import 'package:paragonhealth/Screen/edit_doctor.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorsListPage extends StatefulWidget {
  const DoctorsListPage({Key? key}) : super(key: key);

  @override
  _DoctorsListPageState createState() => _DoctorsListPageState();
}

late String docName, docEmail, docContact, share;

class _DoctorsListPageState extends State<DoctorsListPage> {
  final Stream<QuerySnapshot> doctor = FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('doctor')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor'),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.cyan[100],
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: doctor,
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
                    docContact = data.docs[index]['contact'];
                    docEmail = data.docs[index]['email'];
                    docName = data.docs[index]['name'];
                    if (data.docs[index]['sharing'] == true) {
                      share = "On";
                    } else {
                      share = "Off";
                    }

                    return Card(
                      margin: const EdgeInsets.all(10.0),
                      color: Colors.lightBlue.shade200,
                      elevation: 1.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'Name: $docName\nEmail: $docEmail\nContact no: $docContact\nSharing: $share',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    size: 20.0,
                                    color: Colors.brown[900],
                                  ),
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EditDoctor(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddDoctor()));
        },
        child: const Icon(Icons.add_rounded),
        backgroundColor: Colors.red[900],
      ),
    );
  }
}
