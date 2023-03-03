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
  Image? image1, image2;
  String? base64Image1, base64Image2;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Picker Boss"),
        ),
        body: Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            image1 == null
                ? profileBoxUtil("Side Profile")
                : SizedBox(width: 200.0, height: 300.0, child: image1),
            image2 == null
                ? profileBoxUtil("Top Profile")
                : SizedBox(width: 200.0, height: 300.0, child: image2),
            TextButton(
                onPressed: () => postImage(), child: const Text('Upload'))
          ],
        )));
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

  Widget profileBoxUtil(String name) {
    return GestureDetector(
      onTap: () => dialogBoxUtil(name),
      child: SizedBox(
          width: 200.0,
          height: 300.0,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Icon(Icons.insert_photo_rounded)),
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
    final filePath = await Navigator.pushNamed(context, '/camera');

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
    print("Entered post");
    var url = ' '; //TBD
    final response = await http.post(
      url as Uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          <String, String>{'Image1': base64Image1!, 'Image2': base64Image2!}),
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
