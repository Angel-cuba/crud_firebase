import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: const Center(
        child: Text(
          'Detail Screen',
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
      ),
    );
  }
}
