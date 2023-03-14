import 'package:fitfoot/pages/instructions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Did you know?\nThere are 3 types of foot arches",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: screenWidth,
                  height: screenHeight / 4,
                  child: Image.asset('images/foot-arches.png'),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Text(
                    "\t\tThese foot arches vary from person to person based on their genetics and lifestyle adaptations\n\n\t\tWhat's interesting is that these foot arches can directly impact the way your foot moves when it comes in contact with the ground\n\n\t\tThe way your foot makes contact with the ground has direct corelation with the possibility of an injury from extreme cases\n\n",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                    width: screenWidth,
                    height: screenHeight / 5,
                    child: const Image(
                      image: AssetImage('images/foot-pronation.png'),
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  height: screenHeight / 35,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Text(
                    "\t\tWhile some extent of any type of landing is fine(pronation/supination/neutral), over-pronation or pronation at a great degree could be highly prone to injuries, especially in newer athletes\n\n\t\tFitfoot will help you assess your arch-type using images of your foot from your camera/gallery\n\n\t\tFitfoot can also judge your toe-splaying requirements by accessing your foot's top profile\n\n\t\tYou can proceed to input your foot's top and side profile to help assess the type and thereby help make an investment on the right pair of shoes based on your foot",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: screenHeight / 35,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Proceed"),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        primary: Colors.purple)),
                SizedBox(
                  height: screenHeight / 32,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
