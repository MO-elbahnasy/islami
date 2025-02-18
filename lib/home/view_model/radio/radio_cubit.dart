import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamy/home/view_model/radio/radio_state.dart';
import '../../../core/helper/api_service.dart';
import '../../model/radio_model.dart';
class RadioCubit extends Cubit<RadioState> {
  RadioCubit(this.apiService) : super(RadioStateInitialState());
  List<RadioStation> radioList =[];
  final ApiService apiService;

  Future<void> getRadioList ()async{
    emit(RadioLoadingState());
    try{
      var result =await  apiService.get(url: "https://mp3quran.net/api/v3/radios?language=ar");
      List<dynamic> listJson = result["radios"];
      List<RadioStation> radios =[];
      for (int i = 0; i < listJson.length; i++) {
        radios.add(RadioStation.fromJson(listJson[i]));
      }
      radioList =radios;
      emit(RadioSuccessState());
    }catch(e){
      emit(RadioFailureState(errorMessage: e.toString()));
    }

  }

}