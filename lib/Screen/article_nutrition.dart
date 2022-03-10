import 'package:flutter/material.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({Key? key}) : super(key: key);

  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Nutrition and Health'),
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
                "Nutrition and Health",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              child: Text(
                "Key Facts",
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
                  "Energy intake (calories) should be in balance with energy expenditure. To avoid unhealthy weight gain, total fat should not exceed 30% of total energy intake. Intake of saturated fats should be less than 10% of total energy intake, and intake of trans-fats less than 1% of total energy intake.",
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
                "A healthy diet includes the following:",
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              width: 500,
              height: 340,
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Less than 10% of total energy intake from free sugars, which is equivalent to 50 g (or about 12 level teaspoons) for a person of healthy body weight consuming about 2000 calories per day, but ideally is less than 5% of total energy intake for additional health benefits. \n\nFree sugars are all sugars added to foods or drinks by the manufacturer, cook or consumer, as well as sugars naturally present in honey, syrups, fruit juices and fruit juice concentrates. ",
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
                "Practical advices on\nmaintaining a healthy diet: ",
                textAlign: TextAlign.center,
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
                  "1. Limiting the consumption of foods and drinks containing high amounts of sugars, such as sugary snacks, candies and sugar-sweetened beverages.\n2. Base your meals on higher fibre starchy carbohydrates.\n3. Eat less salt: no more than 6g a day for adults.\n4. Get active and be a healthy weight.\n5. Drink plenty of fluids to stop you getting dehydrated.",
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
