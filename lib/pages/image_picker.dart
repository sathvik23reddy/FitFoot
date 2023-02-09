import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cross_file_image/cross_file_image.dart';

class imagePicker extends StatefulWidget {
  const imagePicker({super.key});

  @override
  _imagePickerState createState() => _imagePickerState();
}

class _imagePickerState extends State<imagePicker> {
  Image? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Picker Boss"),
        ),
        body: Container(
          child: imageFile == null
              ? Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          _getFromGallery();
                        },
                        child: Text("PICK FROM GALLERY"),
                      ),
                      Container(
                        height: 40.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _getFromCamera();
                        },
                        child: Text("PICK FROM CAMERA"),
                      )
                    ],
                  ),
                )
              : Container(child: imageFile),
        ));
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = Image(image: XFileImage(pickedFile));
      });
    }
  }

  _getFromCamera() async {
    final filePath = await Navigator.pushNamed(context, '/camera');

    if (filePath != null) {
      setState(() {
        imageFile = Image.file(File(filePath as String));
      });
    }
  }
}
