import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';

import '../view_model/dates/dates_cubit.dart';

class DatesTab extends StatefulWidget {
  const DatesTab({super.key});

  @override
  State<DatesTab> createState() => _DatesTabState();
}

class _DatesTabState extends State<DatesTab> {
  // Milady date
  DateTime dateNow = DateTime.timestamp();

  late int day = dateNow.day;

  late String dayName = getDayName(dateNow.weekday);

  late String month = _getMonthName(dateNow.month);

  late int year = dateNow.year;

  late String formattedDate = '$day $month \n $year';

  String _getMonthName(int month) {
    const List<String> monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1]; // Month is 1-indexed
  }

  String getDayName(int day) {
    const List<String> dayNames = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return dayNames[day - 1]; // Day is 1-indexed
  }

  // Hijri Date
  HijriCalendar today = HijriCalendar.now();

  late String formattedDateHijri =
      '${today.hDay.toString().padLeft(2, '0')} ${getHijriMonth(today.hMonth)}\n     ${today.hYear}';

  String getHijriMonth(int month) {
    const List<String> hijriMonths = [
      'Muh',
      'Saf',
      'Rab-I',
      'Rab-II',
      'Jum-I',
      'Jum-II',
      'Raj',
      'Sha',
      'Ram',
      'Shaw',
      'Dhu-Q',
      'Dhu-H'
    ];
    return hijriMonths[month - 1]; // Month is 1-indexed
  }

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff856B3F),
                          borderRadius: BorderRadius.circular(40)),
                      child: Image.asset(
                        "assets/images/pray_bg.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Text(
                                  formattedDate,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Pray Time",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontSize: 20,
                                          color: const Color(0x4d202020),
                                        ),
                                    maxLines: 3,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    dayName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontSize: 20),
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 55,
                              ),
                              Text(
                                formattedDateHijri,
                                style: Theme.of(context).textTheme.titleSmall,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<DatesCubit, DatesState>(
                          builder: (context, state) {
                            final cubit = BlocProvider.of<DatesCubit>(context);
                            return Container(
                              alignment: Alignment.center,
                              height: 130,
                              width: double.infinity,
                              child: ListView.separated(
                                itemCount: cubit.prayerList.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 12,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return state is DatesSuccessState
                                      ? Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              gradient: const LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color(0xff202020),
                                                    Color(0xffB19768),
                                                  ])),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                cubit.prayerList[index].key,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                cubit.prayerList[index].value,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                            ],
                                          ))
                                      : state is DatesLoadingState
                                          ? const CircularProgressIndicator()
                                          : state is DatesFaliureState
                                              ? Text(
                                                  state.errorMessage,
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                )
                                              : const SizedBox();
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Next Pray -02:23",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: const Color(0xf0202020)),
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Text(
                        "Azkar",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        "assets/images/eveningAzkar.png",
                        fit: BoxFit.fill,
                        height: 220,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Image.asset(
                        "assets/images/morningAzkar.png",
                        fit: BoxFit.fill,
                        height: 220,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
