import 'package:flutter/material.dart';
import 'package:islamy/models/sura_details_model.dart';
import 'package:islamy/my_them.dart';

class SuraNameItemHorizontal extends StatelessWidget {
  SuraDetailsModel suraModel ;

  SuraNameItemHorizontal(
      {super.key,
      required this.suraModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyThem.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  suraModel.suraNameEn,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black
                  ),
                ),
                Text(
                  suraModel.suraNameAr,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black
                  ),
                ),
                Text(
                  "${suraModel.suraVerses} Verses",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black
                  ),
                )
              ],
            ),
            Image.asset(
              "assets/images/sura_horizontal.png",
            ),
          ],
        ),
      ),
    );
  }
}
