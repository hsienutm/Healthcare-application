import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:paragonhealth/Screen/select_bp.dart';

class BloodPressurePage extends StatefulWidget {
  const BloodPressurePage({Key? key}) : super(key: key);

  @override
  _BloodPressurePageState createState() => _BloodPressurePageState();
}

class _BloodPressurePageState extends State<BloodPressurePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Pressure'),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.cyan[100],
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: const Text("About Blood Pressure",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              width: 500,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Blood pressure is the force of blood pushing against the walls of the arteries as your heart pumps blood. It includes two measurements. 'Systolic' (SYS) is your blood pressure when your heart beats while pumping blood. 'Diastolic' (DIA) is your blood pressure when the heart is at rest between beats.",
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            DataTable2(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'BP\nCategory',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 8),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'SYS',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 8),
                  ),
                ),
                DataColumn(
                  label: Text(
                    '',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'DIA',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 8),
                  ),
                ),
              ],
              rows: const <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('NORMAL', style: TextStyle(fontSize: 8))),
                    DataCell(Text('< 120', style: TextStyle(fontSize: 8))),
                    DataCell(Text('and', style: TextStyle(fontSize: 8))),
                    DataCell(Text('< 80', style: TextStyle(fontSize: 8))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('ELEVATED', style: TextStyle(fontSize: 8))),
                    DataCell(Text('120 - 129', style: TextStyle(fontSize: 8))),
                    DataCell(Text('and', style: TextStyle(fontSize: 8))),
                    DataCell(Text('< 80', style: TextStyle(fontSize: 8))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                        Text('HIGH BP STAGE 1', style: TextStyle(fontSize: 8))),
                    DataCell(Text('130 - 139', style: TextStyle(fontSize: 8))),
                    DataCell(Text('or', style: TextStyle(fontSize: 8))),
                    DataCell(Text('80 - 89', style: TextStyle(fontSize: 8))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                        Text('HIGH BP STAGE 2', style: TextStyle(fontSize: 8))),
                    DataCell(Text('>= 140', style: TextStyle(fontSize: 8))),
                    DataCell(Text('or', style: TextStyle(fontSize: 8))),
                    DataCell(Text('>= 90', style: TextStyle(fontSize: 8))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('HYPERTENSIVE CRISIS',
                        style: TextStyle(fontSize: 8))),
                    DataCell(Text('> 180', style: TextStyle(fontSize: 8))),
                    DataCell(Text('and/or', style: TextStyle(fontSize: 8))),
                    DataCell(Text('> 120', style: TextStyle(fontSize: 8))),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SelectRecordOrReminder()));
        },
        child: const Icon(Icons.add_rounded),
        backgroundColor: Colors.red[900],
      ),
    );
  }
}
