import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: <Widget>[
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.purpleAccent, // Text Color
              ),
              onPressed: () => Navigator.pushNamed(context, '/history'),
              child: Text("History")),
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueAccent, // Text Color
              ),
              onPressed: () => Navigator.pushNamed(context, '/camera'),
              child: Text("Camera"))
        ]),
      ),
    );
  }
}
