import 'package:crud_firebase/navigation/navigator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NavigateToPage())));
  }

  @override
  Widget build(BuildContext context) {
    final fullHeight = MediaQuery.of(context).size.height;
    final fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: fullHeight,
      width: fullWidth,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/blue_sky.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(
        child: Text(
          'Welcome',
          style: TextStyle(
              fontSize: 60.0,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}
