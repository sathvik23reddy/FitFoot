// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:fitfoot/pages/cam.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fitfoot/pages/results.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:adaptive_dialog/adaptive_dialog.dart';

class imagePicker extends StatefulWidget {
  const imagePicker({super.key, required this.cameraToUse});
  final CameraDescription cameraToUse;
  @override
  _imagePickerState createState() => _imagePickerState();
}

class _imagePickerState extends State<imagePicker> {
  Image? image1, image2;
  String? base64Image1, base64Image2;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Stack(children: [
        Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
              width: width / 5,
              height: height / 21,
              child: FloatingActionButton(
                  backgroundColor: Colors.purple,
                  child: Text("Upload"),
                  onPressed: () => postImage(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0))),
            ),
            body: Scaffold(
                body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    image1 == null
                        ? profileBoxUtil("Side Profile", width, height)
                        : SizedBox(
                            width: width, height: height / 3.34, child: image1),
                    image1 == null
                        ? Container()
                        : TextButton(
                            onPressed: () => dialogBoxUtil("Side Profile"),
                            child: const Text("Rechoose Side Profile",
                                style: TextStyle(color: Colors.black)),
                          ),
                  ],
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      image2 == null
                          ? profileBoxUtil("Top Profile", width, height)
                          : SizedBox(
                              width: width,
                              height: height / 3.34,
                              child: image2),
                      image2 == null
                          ? Container()
                          : TextButton(
                              onPressed: () => dialogBoxUtil("Top Profile"),
                              child: const Text("Rechoose Top Profile",
                                  style: TextStyle(color: Colors.black)))
                    ]),
                SizedBox(
                  height: height / 15,
                )
              ],
            ))),
        isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container()
      ]),
    );
  }

  Future dialogBoxUtil(String name) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          return AlertDialog(
              title: const Text("Choose Image from..."),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: width / 4.5,
                    height: height / 11,
                    child: GestureDetector(
                      onTap: () async {
                        await _getFromGallery(name == "Side Profile" ? 1 : 2);
                        Navigator.pop(context);
                      },
                      child: Card(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.photo_album),
                              Text("Gallery")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width / 4.5,
                    height: height / 11,
                    child: GestureDetector(
                      onTap: () async {
                        await _getFromCamera(name == "Side Profile" ? 1 : 2);
                        Navigator.pop(context);
                      },
                      child: Card(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.camera),
                              Text("Camera")
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ));
        });
  }

  Widget profileBoxUtil(String name, double width, double height) {
    return GestureDetector(
      onTap: () => dialogBoxUtil(name),
      child: SizedBox(
          width: width,
          height: height / 3.34,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Icon(Icons.insert_photo_rounded)),
                Center(child: Text('$name')),
              ],
            ),
          )),
    );
  }

  _getFromGallery(int x) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      Uint8List imageByte = await pickedFile.readAsBytes();
      setState(() {
        x == 1
            ? image1 = Image(image: XFileImage(pickedFile))
            : image2 = Image(image: XFileImage(pickedFile));
        x == 1
            ? base64Image1 = base64.encode(imageByte)
            : base64Image2 = base64.encode(imageByte);
        print("Gallery B64");
      });
    }
  }

  _getFromCamera(int x) async {
    final filePath = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                customCamera(camera_to_use: widget.cameraToUse)));

    if (filePath != null) {
      Uint8List imageByte = await File(filePath as String).readAsBytes();
      setState(() {
        x == 1
            ? image1 = Image.file(File(filePath))
            : image2 = Image.file(File(filePath));
        x == 1
            ? base64Image1 = base64.encode(imageByte)
            : base64Image2 = base64.encode(imageByte);
        print("Camera B64");
      });
    }
  }

  Future<void> postImage() async {
    setState(() {
      isLoading = true;
    });
    print("Entered post");
    if (base64Image1 == null || base64Image2 == null) {
      showOkAlertDialog(
          context: context,
          title: "Missing Images",
          message: "Please input both the image profiles before uploading");
      return;
    }
    final response = await http
        .post(
          Uri.http('192.168.2.178:5000'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'Image1': base64Image1!,
            'Image2': base64Image2!
          }),
        )
        .timeout(const Duration(seconds: 30));
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      print(response.body);
      var data = json.decode(response.body);
      var toe_width = data["toe_width"],
          arch_height = data["arch_height"],
          arch_type = data["arch_type"],
          toe_type = data["toe_type"];
      if (arch_height == -1) {
        showOkAlertDialog(
            context: context, message: "Please recapture image properly");
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Results(
                      arch_type: arch_type,
                      toe_type: toe_type,
                    )));
      }
    } else {
      showOkAlertDialog(
          context: context,
          title: "Error",
          message: "Something went wrong, please try again later");
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
