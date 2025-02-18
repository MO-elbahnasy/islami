import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamy/models/sura_details_model.dart';
import 'package:islamy/my_them.dart';

class SuraDetailsScreen extends StatefulWidget {
  static const String routeName = "suraDetailsScreen";

  const SuraDetailsScreen({super.key});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  List<String> suraLines = [];

  @override
  Widget build(BuildContext context) {
    var suraModel =
        ModalRoute.of(context)?.settings.arguments as SuraDetailsModel;
    if (suraLines.isEmpty) {
      loadSuraFiles(suraModel.index + 1);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          suraModel.suraNameEn,
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            "assets/images/sura_details_bg.png",
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Text(
                    suraModel.suraNameAr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: MyThem.primaryColor,
                            )),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: suraLines[index],
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                TextSpan(
                                  text: "[${index + 1}]",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontSize: 18,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: suraLines.length,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  loadSuraFiles(int index) async {
    String suraFile = await rootBundle.loadString("assets/files/$index.txt");
    List<String> lines = suraFile.split("\n");
    // print(lines);
    suraLines = lines;
    setState(() {});
  }
}
