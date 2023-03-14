import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../models/shoe.dart';

class showItem extends StatelessWidget {
  final shoe x;
  const showItem({super.key, required this.x});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
      child: GestureDetector(
        onTap: () => launchShoePage(x.buy),
        child: SizedBox(
          width: double.infinity,
          height: screenHeight / 4,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                  width: screenWidth / 3,
                  height: screenHeight / 23,
                  child: FittedBox(
                    child: Image.network(x.image),
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: screenHeight / 18,
              ),
              Text(
                x.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void launchShoePage(String buy) async {
    final uri = Uri.parse(buy);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print(await canLaunchUrl(uri));
      throw 'Could not launch $buy';
    }
  }
}
