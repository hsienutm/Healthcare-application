import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/view_fam_list.dart';
import 'package:paragonhealth/Screen/patient_list.dart';

class SelectViewDocOrFam extends StatefulWidget {
  const SelectViewDocOrFam({Key? key}) : super(key: key);

  @override
  _SelectViewDocOrFamState createState() => _SelectViewDocOrFamState();
}

class _SelectViewDocOrFamState extends State<SelectViewDocOrFam> {
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
          title: const Text('View Patient'),
          trailing: const Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DocViewPatient(),
              ),
            );
          },
        ),
        ListTile(
          tileColor: Colors.lightBlue[100],
          title: const Text('View Family Member'),
          trailing: const Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ViewFamilyListPage(),
              ),
            );
          },
        ),
      ]),
    );
  }
}
