import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamy/home/tabs/ahadeth_tap/hadeth_details_screen.dart';
import 'package:islamy/models/hadeth_model.dart';

class AhadithTab extends StatefulWidget {
  const AhadithTab({super.key});

  @override
  State<AhadithTab> createState() => _AhadithTabState();
}

class _AhadithTabState extends State<AhadithTab> {
  List<HadethModel> ahadethList = [];

  @override
  Widget build(BuildContext context) {
    loadHadithFile() {
      rootBundle.loadString("assets/files/ahadeth.txt").then((file) {
        List<String> ahadeth = file.split("#");
        for (String data in ahadeth) {
          List<String> lines = data.trim().split("\n");
          String hadithTittle = lines[0];
          lines.removeAt(0);
          List<String> content = lines;
          HadethModel hadethModel = HadethModel(
            content: content,
            tittle: hadithTittle,
          );
          ahadethList.add(hadethModel);
          // print(hadethModel);
          setState(() {});
        }
      }).catchError((error) {
        print(error.toString());
      });
    }

    if (ahadethList.isEmpty) {
      loadHadithFile();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 30),
              child: Image.asset(
                "assets/images/header_bg.png",
                width: double.infinity,
                height: 170,
              )),
          CarouselSlider(
            options: CarouselOptions(
              height: 570,
              enableInfiniteScroll: true,
            ),
            items: ahadethList.map((hadeth) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        HadethDetailsScreen.routName,
                        arguments: hadeth,
                      );
                    },
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset(
                          "assets/images/hadeth_bg.png",
                          width: double.infinity,
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                hadeth.tittle,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                margin: const EdgeInsets.only(top: 16),
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Text(
                                    hadeth.content[0],
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 16,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
