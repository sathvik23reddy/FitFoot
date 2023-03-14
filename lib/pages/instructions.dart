import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Instructions extends StatelessWidget {
  const Instructions({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
      ),
      child: SafeArea(
        child: PageView(scrollDirection: Axis.horizontal, children: [
          Scaffold(
            backgroundColor: Colors.black,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.arrow_right),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sample Side Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                        ),
                        SizedBox(
                          height: screenHeight / 35,
                        ),
                        SizedBox(
                          width: screenWidth,
                          height: screenHeight / 4,
                          child: Image.asset('images/sample_side_prof.jpg'),
                        ),
                        SizedBox(
                          height: screenHeight / 35,
                        ),
                        const Text(
                            "Please ensure that your foot is placed neutral on the floor or any platform and a clear focused image is taken/chosen\n\n",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18)),
                        const Text(
                          "NOTE: Image should contain length from HEEL to the FOREFOOT (BALLS OF THE FEET) ONLY",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.black,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
              width: screenWidth / 4,
              child: FloatingActionButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28.0))),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Proceed"),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sample Top Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                      SizedBox(
                        height: screenHeight / 35,
                      ),
                      SizedBox(
                        width: screenWidth,
                        height: screenHeight / 4,
                        child: Image.asset('images/sample_top_prof.jpg'),
                      ),
                      SizedBox(
                        height: screenHeight / 35,
                      ),
                      const Text(
                          "Please ensure that your foot is fully covered and excluding your shin\n\n",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
