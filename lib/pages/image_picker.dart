import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:adaptive_dialog/adaptive_dialog.dart';

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
                        child: const Text("Rechoose Side Profile")),
              ],
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  image2 == null
                      ? profileBoxUtil("Top Profile", width, height)
                      : SizedBox(
                          width: width, height: height / 3.34, child: image2),
                  image2 == null
                      ? Container()
                      : TextButton(
                          onPressed: () => dialogBoxUtil("Top Profile"),
                          child: const Text("Rechoose Top Profile"))
                ]),
            Center(
              child: SizedBox(
                width: width / 5,
                height: height / 15,
                child: TextButton(
                    onPressed: () => postImage(), child: const Text('Upload')),
              ),
            )
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
        .timeout(const Duration(seconds: 12));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
