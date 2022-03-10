import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paragonhealth/Screen/articles.dart';
import 'package:paragonhealth/Screen/blood_pressure.dart';
import 'package:paragonhealth/Screen/browse.dart';
import 'package:paragonhealth/Screen/glucose.dart';
import 'package:paragonhealth/Screen/signin.dart';
import 'package:paragonhealth/Screen/sleep.dart';
import 'package:paragonhealth/Screen/view_med_record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paragonhealth/Model/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Future<void> _deleteCacheDir() async {
  final cacheDir = await getTemporaryDirectory();

  if (cacheDir.existsSync()) {
    cacheDir.deleteSync(recursive: true);
  }
}

Future<void> _deleteAppDir() async {
  final appDir = await getApplicationSupportDirectory();

  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
dynamic registeredEmail = _firebaseAuth.currentUser!.email.toString();
bool isDoctor = false;

_signOut() async {
  _deleteCacheDir();
  _deleteAppDir();
  await _firebaseAuth.signOut();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color(0XFF1565C0),
                  ),
                  child: Text(
                    '$registeredEmail',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: const Text('Profile'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Text('Logout'),
                  onTap: () async {
                    await _signOut();
                    if (_firebaseAuth.currentUser == null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          //backgroundColor: Colors.indigo[50],
          appBar: AppBar(
            title: const Text('Paragon Health'),
            backgroundColor: Colors.blue[900],
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(themeNotifier.isDark
                      ? Icons.nightlight_round
                      : Icons.wb_sunny),
                  onPressed: () {
                    themeNotifier.isDark
                        ? themeNotifier.isDark = false
                        : themeNotifier.isDark = true;
                  }),
            ],
          ),
          body: IndexedStack(
            index: _selectedIndex,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 30.0, left: 20.0, right: 10.0),
                    child: Text(
                      'Hello, $registeredEmail',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TableCalendar(
                    daysOfWeekHeight: 30.0,
                    firstDay: DateTime(2020),
                    lastDay: DateTime(2030),
                    focusedDay: DateTime.now(),
                    calendarFormat: format,
                    onFormatChanged: (CalendarFormat _format) {
                      setState(() {
                        format = _format;
                      });
                    },
                    daysOfWeekVisible: true,
                    onDaySelected: (DateTime selectDay, DateTime focusDay) {
                      setState(() {
                        selectedDay = selectDay;
                        focusedDay = focusDay;
                      });
                      print(focusedDay);
                    },
                    calendarStyle: const CalendarStyle(
                        isTodayHighlighted: true,
                        selectedDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        )
                        //selectedTextStyle: TextStyle(color: Colors.white),
                        ),
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },
                  ),
                  Expanded(
                    child: GridView.extent(
                      primary: false,
                      padding: const EdgeInsets.all(16),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      maxCrossAxisExtent: 200.0,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BloodPressurePage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 180,
                            width: 180,
                            child: Card(
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              child: const ListTile(
                                title: Text("Blood Pressure",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 13)),
                              ),
                              elevation: 8,
                              shadowColor: Colors.blueAccent,
                              margin: const EdgeInsets.all(20),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GlucosePage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 180,
                            width: 180,
                            child: Card(
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              child: const ListTile(
                                title: Text("Blood Glucose",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 13)),
                              ),
                              elevation: 8,
                              shadowColor: Colors.blueAccent,
                              margin: const EdgeInsets.all(20),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SleepPage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 180,
                            width: 180,
                            child: Card(
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              child: const ListTile(
                                title: Text("Medication",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 13)),
                              ),
                              elevation: 8,
                              shadowColor: Colors.blueAccent,
                              margin: const EdgeInsets.all(20),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewMedRecord(),
                              ),
                            );
                          },
                          child: Container(
                            height: 180,
                            width: 180,
                            child: Card(
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              child: const ListTile(
                                title: Text("Sleep",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 13)),
                              ),
                              elevation: 8,
                              shadowColor: Colors.blueAccent,
                              margin: const EdgeInsets.all(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Center(
                child: ArticlePage(),
              ),
              const Center(
                child: BrowseScreen(),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_outlined),
                label: 'Article',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_sharp),
                label: 'Browse',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
