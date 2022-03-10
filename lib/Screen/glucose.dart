import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/add_glucose.dart';
import 'package:paragonhealth/Screen/view_glucose_record.dart';

class GlucosePage extends StatefulWidget {
  const GlucosePage({Key? key}) : super(key: key);

  @override
  _GlucosePageStateState createState() => _GlucosePageStateState();
}

class _GlucosePageStateState extends State<GlucosePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _gLevelController = TextEditingController();

  void clearText() {
    _nameController.clear();
    _ageController.clear();
    _gLevelController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        title: const Text('Blood Glucose'),
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
                vertical: 10,
              ),
              child: Text("Healthy Blood Sugar Levels"),
            ),
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Time',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 8),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'With\nDiabetes',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 8),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Without\nDiabetes',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 8),
                  ),
                ),
              ],
              rows: const <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Fasting', style: TextStyle(fontSize: 8))),
                    DataCell(
                        Text('80-130mg/dL', style: TextStyle(fontSize: 8))),
                    DataCell(Text('70-99mg/dL', style: TextStyle(fontSize: 8))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('1-2 hours after meals',
                        style: TextStyle(fontSize: 8))),
                    DataCell(Text('< 180mg/dL', style: TextStyle(fontSize: 8))),
                    DataCell(Text('< 140mg/dL', style: TextStyle(fontSize: 8))),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.cyan.shade900.withOpacity(0.2),
                  blurRadius: 2,
                  offset: const Offset(10, 10),
                )
              ]),
              constraints:
                  const BoxConstraints(maxWidth: 180.0, minHeight: 80.0),
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.cyan.shade900),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ViewGlucoseRecord()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'View Glucose\nRecord',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddGlucoseRecord()));
        },
        child: const Icon(Icons.add_rounded),
        backgroundColor: Colors.red[900],
      ),
    );
  }
}
