import 'package:flutter/material.dart';
import 'package:islamy/home/tabs/ahadeth_tap/ahadith_tab.dart';
import 'package:islamy/home/tabs/dates_tab.dart';
import 'package:islamy/home/tabs/quran_tab/quran_tab.dart';
import 'package:islamy/home/tabs/radio_tab.dart';
import 'package:islamy/home/tabs/sebha_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "assets/images/${backGroundImage()}.png",
            ),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              currentIndex = value;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  icon: _buildBtnItem("quran", 0), label: "Quran"),
              BottomNavigationBarItem(
                  icon: _buildBtnItem("ahades", 1), label: "Hadith"),
              BottomNavigationBarItem(
                  icon: _buildBtnItem("sebha", 2), label: "Tasbeh"),
              BottomNavigationBarItem(
                  icon: _buildBtnItem("radio", 3), label: "Radio"),
              BottomNavigationBarItem(
                  icon: _buildBtnItem("dates", 4), label: "Dates"),
            ]),
        body: tabs[currentIndex],
      ),
    );
  }

  List<Widget> tabs = [
    const QuranTab(),
    const AhadithTab(),
    const SebhaTab(),
    const RadioTab(),
     DatesTab(),
  ];

  String backGroundImage() {
    switch (currentIndex) {
      case 0:
        return "home_bg";
      case 1:
        return "ahageth_bg";
      case 2:
        return "sebha_bg";
      case 3:
        return "radio_bg";
      case 4:
        return "dates_bd";
      default:
        return "home_bg";
    }
  }

  Widget _buildBtnItem(String imageName, int index) {
    return currentIndex == index
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(66),
              color: const Color(0x99202020),
            ),
            child: ImageIcon(
              AssetImage("assets/images/$imageName.png"),
            ),
          )
        : ImageIcon(
            AssetImage("assets/images/$imageName.png"),
          );
  }
}
