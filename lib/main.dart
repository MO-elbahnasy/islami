import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamy/core/helper/api_service.dart';
import 'package:islamy/home/tabs/ahadeth_tap/hadeth_details_screen.dart';
import 'package:islamy/my_them.dart';
import 'package:islamy/onBoarding/onboarding_screen.dart';
import 'package:islamy/sura_details/sura_details.dart';

import 'home/home_screen.dart';
import 'home/view_model/radio/radio_cubit.dart';

void main() {
  runApp( MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RadioCubit(ApiService())..getRadioList()),

      ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      initialRoute: OnboardingScreen.routeName,
      debugShowCheckedModeBanner: false,
      theme: MyThem.lightMode,
      darkTheme: MyThem.darkMode,
      themeMode: ThemeMode.light,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        OnboardingScreen.routeName: (context) =>  OnboardingScreen(),
        SuraDetailsScreen.routeName: (context) => const SuraDetailsScreen(),
        HadethDetailsScreen.routName: (context) => const HadethDetailsScreen(),
      },
    );
  }
}
