import 'package:fitfoot/pages/image_picker.dart';
import 'package:fitfoot/pages/info.dart';
import 'package:fitfoot/pages/instructions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
        ),
        child: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Info()))),
                  child: Text("Information")),
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => Instructions()))),
                  child: Text("Instructions")),
              ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => imagePicker()))),
                  child: Text("Scan your foot")),
            ],
          ),
        ));
  }
}
