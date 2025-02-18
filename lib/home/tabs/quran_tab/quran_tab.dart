import 'package:flutter/material.dart';
import 'package:islamy/home/tabs/quran_tab/sura_name_item_horizontal.dart';
import 'package:islamy/home/tabs/quran_tab/sura_name_item_vertical.dart';
import 'package:islamy/models/sura_details_model.dart';
import 'package:islamy/my_them.dart';
import 'package:islamy/sura_details/sura_details.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(onSearch);
    // setState(() {});
  }

  onSearch() {
    SuraDetailsModel.searchSuraName.clear();
    String text = searchController.text.trim();

    if (text.isNotEmpty) {
      for (int i = 0; i < SuraDetailsModel.suraNameEnglish.length; i++) {
        String englishName = SuraDetailsModel.suraNameEnglish[i].toLowerCase();
        String arabicName = SuraDetailsModel.suraNameArabic[i].toLowerCase();

        if (englishName.contains(text.toLowerCase()) || arabicName.contains(text)) {
          SuraDetailsModel.searchSuraName.add(SuraDetailsModel.suraNameEnglish[i]);
        }
      }
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.only(top: 30),
              child: Image.asset(
                "assets/images/header_bg.png",
                width: double.infinity,
                height: 170,
              )),
          _searchSuraItem(),
          if (SuraDetailsModel.searchSuraName.isEmpty &&
              searchController.text.isEmpty) ...[
            _suraNamesHorizontalList(),
          ],
          _suraNamesVerticalList(),
        ],
      ),
    );
  }

  // Sura Horizontal List
  Widget _suraNamesHorizontalList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Most Recently",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          height: 10,
        ),
        // Horizontal List
        SizedBox(
          width: double.infinity,
          height: 150,
          child: Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      width: 16,
                    ),
                scrollDirection: Axis.horizontal,
                itemCount: SuraDetailsModel.suraNameArabic.length,
                itemBuilder: (context, index) {
                  return SuraNameItemHorizontal(
                      suraModel: SuraDetailsModel.getSuraModel(index));
                }),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  //sura Vertical List
  Widget _suraNamesVerticalList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Sura Details
          Text(
            "Sura List",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          // Vertical List
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.white,
                height: 3,
                endIndent: 40,
                indent: 40,
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, SuraDetailsScreen.routeName,
                          arguments: SuraDetailsModel.getSuraModel(index));
                    },
                    child: SuraNameItemVertical(
                      suraModel: searchController.text.isNotEmpty
                          ? SuraDetailsModel.getSelectedSuraModel(index)
                          : SuraDetailsModel.getSuraModel(index),
                    ),
                  ),
                );
              },
              itemCount: searchController.text.isNotEmpty
                  ? SuraDetailsModel.searchSuraName.length
                  : SuraDetailsModel.length,
            ),
          ),
        ],
      ),
    );
  }

  // Search Button
  Widget _searchSuraItem() {
    return Column(
      children: [
        TextField(
          controller: searchController,
          style: Theme.of(context).textTheme.titleSmall,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xb3202020),
            focusColor: Colors.white,
            hintText: "Sura Name",
            hintStyle: Theme.of(context).textTheme.titleSmall,
            prefixIcon: const ImageIcon(
              AssetImage("assets/images/quran.png"),
              color: MyThem.primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: MyThem.primaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: MyThem.primaryColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: MyThem.primaryColor,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
