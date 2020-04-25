import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'leaderboard.dart';
import 'achievements.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EarthXHack',
      theme: ThemeData.light(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);
  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 1;
  void switchIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> pages = [
    AchievementsPage(),
    HomePage(),
    LeaderboardPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: switchIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            title: Text('Achievements'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered),
            title: Text('Leaderboard'),
          ),
        ],
      ),
    );
  }
}
