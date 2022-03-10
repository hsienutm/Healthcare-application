import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/add_fam.dart';
import 'package:paragonhealth/Screen/edit_fam.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FamilyListPage extends StatefulWidget {
  const FamilyListPage({Key? key}) : super(key: key);

  @override
  _FamilyListPageState createState() => _FamilyListPageState();
}

late String famName, famEmail, famContact, share;

class _FamilyListPageState extends State<FamilyListPage> {
  final Stream<QuerySnapshot> fam = FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('share-family')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Members'),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.cyan[100],
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: fam,
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
                    famContact = data.docs[index]['contact'];
                    famEmail = data.docs[index]['email'];
                    famName = data.docs[index]['name'];
                    if (data.docs[index]['sharing'] == true) {
                      share = "On";
                    } else {
                      share = "Off";
                    }

                    return Card(
                      margin: const EdgeInsets.all(10.0),
                      color: Colors.lightBlue.shade200,
                      elevation: 1.0,
                      child: ListTile(
                        title: Text(
                          'Name: $famName\nEmail: $famEmail\nContact no: $famContact\nSharing: $share',
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
                                    builder: (context) => const EditFamily(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFamily()));
        },
        child: const Icon(Icons.add_rounded),
        backgroundColor: Colors.red[900],
      ),
    );
  }
}
