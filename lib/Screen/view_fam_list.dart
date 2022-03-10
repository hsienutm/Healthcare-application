import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/add_fam.dart';
import 'package:paragonhealth/Screen/edit_fam.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paragonhealth/Screen/view_fam_record.dart';

class ViewFamilyListPage extends StatefulWidget {
  const ViewFamilyListPage({Key? key}) : super(key: key);

  @override
  _ViewFamilyListPageState createState() => _ViewFamilyListPageState();
}

late String famName, famEmail, famContact, share;
dynamic famMemberEmail;

class _ViewFamilyListPageState extends State<ViewFamilyListPage> {
  final Stream<QuerySnapshot> fam = FirebaseFirestore.instance
      .collection('users')
      .doc(registeredEmail)
      .collection('view-family')
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
                    famEmail = data.docs[index]['email'];
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
                          'Email: $famEmail\nSharing: $share',
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
                                Icons.view_list_rounded,
                                size: 30.0,
                                color: Colors.brown[900],
                              ),
                              onPressed: () async {
                                famMemberEmail = data.docs[index]['email'];
                                if (data.docs[index]['sharing']) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ViewFamRecord(),
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
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
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
                    );
                  });
            }),
      ),
    );
  }
}
