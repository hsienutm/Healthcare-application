import 'package:flutter/material.dart';

class CardioFitnessPage extends StatefulWidget {
  const CardioFitnessPage({Key? key}) : super(key: key);

  @override
  _CardioFitnessPageState createState() => _CardioFitnessPageState();
}

class _CardioFitnessPageState extends State<CardioFitnessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Cardio Fitness Article'),
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
                "Cardio Fitness",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              child: Text(
                "What is cardio fitness?",
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              width: 500,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Cardio fitness is a measurement of your VO2 max, which is the maximum amount of oxygen your body can consume during exercise. Your cardio fitness level is a strong indicator of your overall physical health and a predictor of your long-term health. ",
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
                "Measuring Cardio Fitness",
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              width: 500,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "To know your level of fitness, you need to measure it. One way is to simply track your own workouts. Keep track of the activity you do, how long you do it, and how hard you're working. You can then look for trends.\n\nUse a scale of 1 to 10 to match you how you feel at different levels of intensity. Exercising at an easy pace would be a level 2 or 3. If you're sprinting all-out, that would be closer to a 10. ",
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
                "Improving Your Cardio Fitness",
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              width: 500,
              height: 370,
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "1. Steady-state Training\nRunning, walking, using the elliptical, or doing some other cardio activity at a moderate pace for 20 or more minutes. You build endurance in your entire body as well as your heart and lungs to be able to last longer during cardio.\n\n2. Interval Training.\nThis involves going fast or hard and then backing off to recover, repeating these intervals for the duration of the workout. Interval training can help you build endurance more quickly than steady state training.",
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
