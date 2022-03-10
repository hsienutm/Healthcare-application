import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/doctor_list.dart';
import 'package:paragonhealth/Screen/fam_list.dart';
import 'package:paragonhealth/Screen/select_view_doc_fam.dart';

class SelectDocOrFam extends StatefulWidget {
  const SelectDocOrFam({Key? key}) : super(key: key);

  @override
  _SelectDocOrFamState createState() => _SelectDocOrFamState();
}

class _SelectDocOrFamState extends State<SelectDocOrFam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Others'),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.indigo[50],
      body: ListView(children: [
        ListTile(
          tileColor: Colors.lightBlue[100],
          title: const Text('Doctor'),
          trailing: const Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DoctorsListPage(),
              ),
            );
          },
        ),
        ListTile(
          tileColor: Colors.lightBlue[100],
          title: const Text('Family Member'),
          trailing: const Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FamilyListPage(),
              ),
            );
          },
        ),
        ListTile(
          tileColor: Colors.lightBlue[100],
          title: const Text('View Sharing'),
          trailing: const Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectViewDocOrFam(),
              ),
            );
          },
        ),
      ]),
    );
  }
}
