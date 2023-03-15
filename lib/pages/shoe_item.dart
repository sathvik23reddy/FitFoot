import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
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
                    fit: BoxFit.cover,
                    child: Image.network(x.image),
                  )),
              SizedBox(
                height: screenHeight / 18,
              ),
              Text(
                x.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
      throw 'Could not launch $buy';
    }
  }
}
