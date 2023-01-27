import 'package:flutter/material.dart';

class SprintScreen extends StatelessWidget {
  const SprintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          'Sprint Screen',
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
      ),
    );
  }
}
