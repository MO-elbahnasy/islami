import 'package:flutter/material.dart';
import 'package:islamy/models/hadeth_model.dart';
import 'package:islamy/my_them.dart';

class HadethDetailsScreen extends StatelessWidget {
  static const String routName = "HadethDetailsScreen";

  const HadethDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var hadithModel = ModalRoute.of(context)?.settings.arguments as HadethModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          hadithModel.tittle,
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
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Container(
                //   margin: const EdgeInsets.only(top: 30),
                //   child: Text(
                //     hadithModel.tittle,
                //     style: Theme.of(context).textTheme.titleMedium,
                //   ),
                // ),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: hadithModel.content[index],
                                  style:
                                  Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: hadithModel.content.length,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


}
