// ignore_for_file: prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fitfoot/pages/home.dart';
import 'package:fitfoot/pages/history.dart';
import 'package:fitfoot/pages/cam.dart';
import 'pages/image_picker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final cameraToUse = cameras.first;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/history': (context) => History(),
      '/imagePicker': (context) => imagePicker(),
      '/camera': (context) => customCamera(camera_to_use: cameraToUse)
    },
  ));
}
