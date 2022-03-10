import 'package:flutter/material.dart';

class DiseasesPage extends StatefulWidget {
  const DiseasesPage({Key? key}) : super(key: key);

  @override
  _DiseasesPageState createState() => _DiseasesPageState();
}

class _DiseasesPageState extends State<DiseasesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Symptoms of Diseases'),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.cyan[100],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
              child: Text(
                "Symptoms of several diseases",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              child: Text(
                "Stroke",
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              width: 500,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "1. Sudden numbness or weakness in the face, arm, or leg, especially on one side of the body.\n2. Sudden confusion, trouble speaking, or difficulty understanding speech.\n3. Sudden trouble seeing in one or both eyes.\n4. Sudden trouble walking, dizziness, loss of balance, or lack of coordination.\n5. Sudden severe headache with no known cause.",
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(
              child: Text(
                "Heart Attack",
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              width: 500,
              height: 230,
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "1. Chest pain or discomfort. \n2. Feeling weak, light-headed, or faint. \n3. Pain or discomfort in the jaw, neck, or back. \n4. ain or discomfort in one or both arms or shoulders. \n5. Shortness of breath. \n6. Nausea and cold sweats.",
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(
              child: Text(
                "Diabetes",
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              width: 500,
              height: 230,
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "1. Urinate a lot, often at night. \n2. Often thirsty. \n3. Lose weight without trying. \n4. Often hungry. \n5. Have blurry vision. \n6. Have numb or tingling hands or feet. \n7. Often tired. \n8. Dry and itchy skin.",
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(
              child: Text(
                "High Blood Pressure",
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              width: 500,
              height: 230,
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "1. Headache. \n2. Nosebleed. \n3. Breathlessness. \n4. Tinnitus.\n5. Sleepiness.\n6. Cofusion.\n 7. Fatigue. \n8. Excess sweating.",
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
