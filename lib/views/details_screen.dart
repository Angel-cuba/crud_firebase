import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          'Detail Screen',
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
      ),
    );
  }
}
