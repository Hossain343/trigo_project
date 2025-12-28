import 'package:flutter/material.dart';
import 'home_page.dart';
import 'activity_page.dart';
import 'activities_page.dart';
import 'device_page.dart';
import 'team_page.dart';
import 'message_page.dart';
import 'my_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _index = 0;

  final List<Widget> pages = const [
    MyPage(),
    HomePage(),
    ActivityPage(),
    ActivitiesPage(),
    DevicePage(),
    TeamPage(),
    MessagePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'MY'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: 'ACTIVITY'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'ACTIVITIES'),
          BottomNavigationBarItem(icon: Icon(Icons.devices), label: 'DEVICE'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'TEAM'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'MESSAGE'),
        ],
      ),
    );
  }
}
