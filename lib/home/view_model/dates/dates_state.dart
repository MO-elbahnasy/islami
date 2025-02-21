part of 'dates_cubit.dart';


abstract class DatesState {}

final class DatesInitialState extends DatesState {}
final class DatesLoadingState extends DatesState {}
final class DatesSuccessState extends DatesState {
  final   PrayerTimesModel model ;

  DatesSuccessState({required this.model});
}
final class DatesFaliureState extends DatesState {
  final String errorMessage;

  DatesFaliureState({required this.errorMessage});
}
