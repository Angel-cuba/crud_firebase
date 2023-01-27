import 'package:crud_firebase/views/details_screen.dart';
import 'package:crud_firebase/views/home_screen.dart';
import 'package:crud_firebase/views/sprint_screen.dart';
import 'package:flutter/material.dart';

import 'views/profile_screen.dart';

class NavigateToPage extends StatefulWidget {
  const NavigateToPage({super.key});

  @override
  State<NavigateToPage> createState() => _NavigateToPageState();
}

class _NavigateToPageState extends State<NavigateToPage> {
  int _selectedIndex = 0;
  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(
      title: '',
    ),
    DetailScreen(),
    ProfileScreen(),
    SprintScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: _selectedIndex == 0 ? 30 : 24),
            label: 'Home',
            backgroundColor: Colors.amberAccent.shade700,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details, size: _selectedIndex == 1 ? 30 : 24),
            label: 'Details',
            backgroundColor: Colors.greenAccent.shade700,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: _selectedIndex == 2 ? 30 : 24),
            label: 'Profile',
            backgroundColor: Colors.blueAccent.shade700,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports, size: _selectedIndex == 3 ? 30 : 24),
            label: 'Sprint',
            backgroundColor: Colors.black26,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.redAccent.shade700,
        // unselectedItemColor: Colors.blueGrey.shade300,
        showSelectedLabels: false,
        // showUnselectedLabels: false,
        onTap: _onTabSelected,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
