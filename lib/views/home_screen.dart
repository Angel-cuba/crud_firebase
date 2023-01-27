import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(Icons.menu),
        ),
        backgroundColor: Colors.redAccent.shade700,
        title: const Text('Flutter CRUD with Firebase'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 230.0),
        child: Column(children: [
          Text('Login with Google',
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.redAccent.shade700,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20.0),
          const Text('This is a simple CRUD app with Firebase',
              style: TextStyle(fontSize: 20.0, color: Colors.black)),
        ]),
      ),
    );
  }
}
