// ignore_for_file: prefer_const_constructors

import 'package:fitfoot/pages/camera.dart';
import 'package:flutter/material.dart';
import 'package:fitfoot/pages/home.dart';
import 'package:fitfoot/pages/history.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/history': (context) => History(),
        '/camera': (context) => Camera()
      },
    ));
