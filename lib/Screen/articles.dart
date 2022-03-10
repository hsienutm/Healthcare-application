import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/article_cardio.dart';
import 'package:paragonhealth/Screen/article_sleep_stages.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:paragonhealth/Screen/article_nutrition.dart';
import 'package:paragonhealth/Screen/article_disease.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.cyan[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InkWell(
              child: Container(
                height: 200,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://i.shgcdn.com/b6244846-e5b5-4094-81dc-ba8859dd2b68/-/format/auto/-/preview/3000x3000/-/quality/lighter/'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Learn About Cardio Fitness",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CardioFitnessPage()));
              },
            ),
            InkWell(
              child: Container(
                height: 200,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://amerisleep.com/blog/wp-content/uploads/2020/04/Four_Stages_of_Sleep-01-scaled.jpg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Learn About Sleep Stages",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SleepStagesPage()));
              },
            ),
            InkWell(
              child: Container(
                height: 200,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://extension.missouri.edu/media/wysiwyg/Extensiondata/Int/YouthAndFamily/Images/stethoscope-vegetables-table-905.jpg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Nurition and Health",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NutritionPage()));
              },
            ),
            InkWell(
              child: Container(
                height: 200,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://www.stoptheclot.org/wp-content/uploads/2016/06/AdobeStock_71913139.jpeg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Symptoms of diseases",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DiseasesPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
