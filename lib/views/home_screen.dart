import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    final fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(Icons.menu),
        ),
        backgroundColor: Colors.redAccent.shade700,
        title: Text("TODO $title"),
      ),
      body: Container(
        alignment: Alignment.center,
        height: fullHeight,
        width: fullWidth,
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
