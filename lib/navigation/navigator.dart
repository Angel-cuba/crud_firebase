import 'package:crud_firebase/views/details_screen.dart';
import 'package:crud_firebase/views/home_screen.dart';
import 'package:crud_firebase/views/settings_screen.dart';
import 'package:crud_firebase/views/sprint_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../views/profile_screen.dart';

class NavigateToPage extends StatefulWidget {
  const NavigateToPage({super.key});

  @override
  State<NavigateToPage> createState() => _NavigateToPageState();
}

class _NavigateToPageState extends State<NavigateToPage> {
  int _selectedIndex = 2;
  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    DetailScreen(),
    SprintScreen(),
    HomePage(),
    ProfileScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: const Key('bottomNavigationBar'),
        items: <Widget>[
          Icon(Icons.sports,
              size: _selectedIndex == 0 ? 30 : 24,
              color: _selectedIndex == 0 ? Colors.white70 : null),
          Icon(Icons.medication_liquid_sharp,
              size: _selectedIndex == 1 ? 30 : 24,
              color: _selectedIndex == 1 ? Colors.white70 : null),
          Icon(
            Icons.home,
            size: _selectedIndex == 2 ? 36 : 24,
            color: _selectedIndex == 2 ? Colors.redAccent.shade200 : null,
            shadows: [
              Shadow(
                blurRadius: 2.0,
                color: _selectedIndex == 2
                    ? Colors.redAccent.shade200
                    : Colors.white70,
              ),
            ],
          ),
          Icon(
            Icons.person,
            size: _selectedIndex == 3 ? 30 : 24,
            color: _selectedIndex == 3 ? Colors.white70 : null,
          ),
          Icon(Icons.settings_suggest,
              size: _selectedIndex == 4 ? 30 : 24,
              color: _selectedIndex == 4 ? Colors.white70 : null),
        ],
        onTap: _onTabSelected,
        animationDuration: const Duration(milliseconds: 400),
        backgroundColor: Colors.transparent,
        color: Colors.grey.shade700,
        buttonBackgroundColor: Colors.blueGrey.shade400,
        index: 2,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
