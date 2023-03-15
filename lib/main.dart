import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fitfoot/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitfoot/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final cameraToUse = cameras.first;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(cameraToUse: cameraToUse),
  ));
}
