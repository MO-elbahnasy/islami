import 'package:bloc/bloc.dart';
import 'package:islamy/core/helper/api_service.dart';

import '../../model/dates_model.dart';

part 'dates_state.dart';

class DatesCubit extends Cubit<DatesState> {
  DatesCubit(this.apiService) : super(DatesInitialState());
  final ApiService apiService;
  List<MapEntry<String, String>> prayerList = [];

  Future<void> getDates() async {
    emit(DatesLoadingState());
    try {
      var result = await apiService.get(
          url:
              "https://api.aladhan.com/v1/timingsByCity/16-07-2024?city=cairo&country=egypt");
      final model = PrayerTimesModel.fromJson(result);
      prayerList = [
        MapEntry("Fajr", model.timings.fajr),
        MapEntry("Sunrise", model.timings.sunrise),
        MapEntry("Dhuhr", model.timings.dhuhr),
        MapEntry("Asr", model.timings.asr),
        MapEntry("Maghrib", model.timings.maghrib),
        MapEntry("Isha", model.timings.isha),
      ];
      emit(DatesSuccessState(model: model));
    } catch (e) {
      emit(DatesFaliureState(errorMessage: e.toString()));
    }
  }
}
