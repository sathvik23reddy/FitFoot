import 'package:camera/camera.dart';
import 'package:fitfoot/pages/image_picker.dart';
import 'package:fitfoot/pages/info.dart';
import 'package:fitfoot/pages/instructions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.cameraToUse});
  final CameraDescription cameraToUse;
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
          statusBarColor: Color(0xFF0a0a0a),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: screenHeight / 2.5,
                      width: screenWidth / 2.5,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Info()))),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.lock_open_sharp,
                                  size: 45,
                                ),
                                SizedBox(
                                  height: screenHeight / 28,
                                ),
                                Text(
                                  "Did you know?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: screenHeight / 2.5,
                      width: screenWidth / 2.5,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Instructions()))),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info,
                                  size: 45,
                                ),
                                SizedBox(
                                  height: screenHeight / 28,
                                ),
                                Text(
                                  "Instructions",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: screenHeight / 2.2,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => imagePicker(
                                    cameraToUse: widget.cameraToUse)))),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.document_scanner_outlined,
                                size: 45,
                              ),
                              SizedBox(
                                height: screenHeight / 18,
                              ),
                              Text(
                                "Scan your foot",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 31),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
