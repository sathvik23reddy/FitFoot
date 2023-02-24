import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class imagePicker extends StatefulWidget {
  const imagePicker({super.key});
  @override
  _imagePickerState createState() => _imagePickerState();
}

class _imagePickerState extends State<imagePicker> {
  Image? imageFile;
  String? base64Image;

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
                      ),
                    ],
                  ),
                )
              : Scaffold(
                  body: Column(
                  children: [
                    Container(child: imageFile),
                    ElevatedButton(
                      onPressed: () {
                        postImage();
                      },
                      child: Text("SEND IMAGE AWAY"),
                    )
                  ],
                )),
        ));
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      Uint8List imageByte = await pickedFile.readAsBytes();
      setState(() {
        imageFile = Image(image: XFileImage(pickedFile));
        base64Image = base64.encode(imageByte);
        print("Gallery B64 ${base64Image!}");
      });
    }
  }

  _getFromCamera() async {
    final filePath = await Navigator.pushNamed(context, '/camera');

    if (filePath != null) {
      Uint8List imageByte = await File(filePath as String).readAsBytes();
      setState(() {
        imageFile = Image.file(File(filePath));
        base64Image = base64.encode(imageByte);
        print("CAMERA B64 ${base64Image!}");
      });
    }
  }

  Future<void> postImage() async {
    print("Entered post");
    final response = await http.post(
      Uri.https('fitfoot-api.onrender.com'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'Image': base64Image!,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
