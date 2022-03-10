import 'package:flutter/material.dart';

class SleepStagesPage extends StatefulWidget {
  const SleepStagesPage({Key? key}) : super(key: key);

  @override
  _SleepStagesPageState createState() => _SleepStagesPageState();
}

class _SleepStagesPageState extends State<SleepStagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sleep Stages Article'),
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
                "Sleep Stages",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              child: Text(
                "Stage 1",
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
                  "non-REM sleep is the changeover from wakefulness to sleep.  During this short period (lasting several minutes) of relatively light sleep, your heartbeat, breathing, and eye movements slow, and your muscles relax with occasional twitches.  Your brain waves begin to slow from their daytime wakefulness patterns. ",
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
                "Stage 2",
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              width: 500,
              height: 270,
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "non-REM sleep is a period of light sleep before you enter deeper sleep.  Your heartbeat and breathing slow, and muscles relax even further.  Your body temperature drops and eye movements stop.  Brain wave activity slows but is marked by brief bursts of electrical activity.  You spend more of your repeated sleep cycles in stage 2 sleep than in other sleep stages.",
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
                "Stage 3",
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              width: 500,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "non-REM sleep is the period of deep sleep that you need to feel refreshed in the morning.  It occurs in longer periods during the first half of the night.  Your heartbeat and breathing slow to their lowest levels during sleep.  Your muscles are relaxed and it may be difficult to awaken you. Brain waves become even slower.",
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
                "REM Sleep ",
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              width: 500,
              height: 430,
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "first occurs about 90 minutes after falling asleep. Your eyes move rapidly from side to side behind closed eyelids.  Mixed frequency brain wave activity becomes closer to that seen in wakefulness.  Your breathing becomes faster and irregular, and your heart rate and blood pressure increase to near waking levels.  Most of your dreaming occurs during REM sleep, although some can also occur in non-REM sleep. Your arm and leg muscles become temporarily paralyzed, which prevents you from acting out your dreams.  As you age, you sleep less of your time in REM sleep. Memory consolidation most likely requires both non-REM and REM sleep.",
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
