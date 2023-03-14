// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Results extends StatefulWidget {
  final String arch_type, toe_type;
  const Results({super.key, required this.arch_type, required this.toe_type});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: screenWidth / 2,
        height: screenHeight / 24,
        child: FloatingActionButton(
          backgroundColor: Colors.pink[400],
          onPressed: () {},
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28.0))),
          child: Text("View Shoe Suggestions"),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 14),
            child: Text(
              "Your foot has a " +
                  widget.arch_type +
                  "\nYour toes are " +
                  (widget.toe_type == "Wide Toe Box"
                      ? "wider than usual"
                      : "of normal width"),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
          ),
          widget.arch_type == "Flat Arch"
              ? Image.network(
                  "https://img.buzzfeed.com/buzzfeed-static/static/2015-07/7/15/enhanced/webdr12/anigif_enhanced-5710-1436296947-3.gif")
              : Image.network(
                  "https://img.buzzfeed.com/buzzfeed-static/static/2015-07/7/15/enhanced/webdr04/anigif_enhanced-19395-1436296926-2.gif"),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 14, 10, 0),
            child: Text(
              "Your foot tends to " +
                  (widget.arch_type == "Flat Arch"
                      ? "over pronate (roll inwards) as you land"
                      : "have normal pronation"),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
          )
        ],
      ),
    );
  }
}
