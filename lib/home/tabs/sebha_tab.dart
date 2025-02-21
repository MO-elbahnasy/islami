import 'package:flutter/material.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int index = 0;
  int counter = 0;
  List<String> tasabeh = ["سبحان الله", "الحمدلله", "الله اكبر"];
  String label = "";
  double turns = 0.0;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30),
            child: Image.asset(
              "assets/images/header_bg.png",
              width: double.infinity,
              height: 170,
            ),
          ),
          Text(
            "سَبِّحِ اسْمَ رَبِّكَ الأعلى ",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 60),
                  child: Image.asset(
                    "assets/images/tasbeh_header.png",
                    fit: BoxFit.fill,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    index++;
                    if (index == 34) {
                      counter = counter + 1;
                      index = 0;
                      if (counter == 3) {
                        counter = 0;
                      }
                    }
                    setState(() => turns += 1.0 / 30);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedRotation(
                        turns: turns,
                        duration: const Duration(milliseconds: 500),
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/images/tasbeh_bg.png",
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            tasabeh[counter],
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "$index",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
