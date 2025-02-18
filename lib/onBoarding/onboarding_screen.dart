import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islamy/my_them.dart';

import '../home/home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = "/";
  Color dotsColor = const Color(0xff707070);

  OnboardingScreen({super.key});

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: MyThem.primaryColor,
    );

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: MyThem.primaryColor),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: MyThem.blackColor,
      imagePadding: EdgeInsets.zero,
      imageFlex: 4,
    );

    return IntroductionScreen(
      globalBackgroundColor: MyThem.blackColor,
      allowImplicitScrolling: true,
      //Finish Btn
      showDoneButton: true,
      done: FittedBox(
        child: Text(
          "Finish",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
      onDone: () {
        Navigator.pushNamed(context, HomeScreen.routeName);
      },
      //Next Btn
      showNextButton: true,
      next: Text(
        "Next",
        style: Theme.of(context).textTheme.bodySmall,
      ),
      //Back Btn
      showBackButton: true,
      back: Text(
        "Back",
        style: Theme.of(context).textTheme.bodySmall,
      ),
      //
      // Dots
      dotsFlex: 3,
      dotsDecorator: DotsDecorator(
        color: dotsColor,
        activeColor: Theme.of(context).primaryColor,
        activeSize: const Size(24, 8),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(27),
          ),
        ),
      ),
      // Global Header
      globalHeader: Align(
        alignment: Alignment.center,
        child: SafeArea(
          child: _buildImage('header_bg.png', 350),
        ),
      ),
      // Pages
      pages: [
        // Page1
        PageViewModel(
          title: "Welcome To Isalmi App",
          body: "",
          image: _buildImage('onboarding1.png'),
          decoration: pageDecoration,
        ),
        // Page2
        PageViewModel(
          title: "Welcome To Isalmi App",
          body: "We Are Very Excited To Have You In Our Community",
          image: _buildImage('onboarding2.png'),
          decoration: pageDecoration,
        ),
        // Page3
        PageViewModel(
          title: "Reading the Quran",
          body: "Read, and your Lord is the Most Generous",
          image: _buildImage('onboarding4.png'),
          decoration: pageDecoration,
        ),
        // Page4
        PageViewModel(
          title: "Bearish",
          body: "Read, and your Lord is the Most Generous",
          image: _buildImage('onboarding3.png'),
          decoration: pageDecoration,
        ),
        // Page5
        PageViewModel(
          title: "Holy Quran Radio",
          body:
              "You can listen to the Holy Quran Radio through the application for free and easily",
          image: _buildImage('onboarding5.png'),
          decoration: pageDecoration,
        ),
      ],
    );
  }
}
