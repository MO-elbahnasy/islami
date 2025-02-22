import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamy/home/view_model/radio/radio_state.dart';
import 'package:just_audio/just_audio.dart';
import '../../../core/helper/api_service.dart';
import '../../model/radio_model.dart';
class RadioCubit extends Cubit<RadioState> {
  RadioCubit(this.apiService) : super(RadioStateInitialState());
  List<RadioStation> radioList = [];
  final ApiService apiService;

  Future<void> getRadioList() async {
    emit(RadioLoadingState());
    try {
      var result = await apiService.get(
          url: "https://mp3quran.net/api/v3/radios?language=ar");
      List<dynamic> listJson = result["radios"];
      List<RadioStation> radios = [];
      for (int i = 0; i < listJson.length; i++) {
        radios.add(RadioStation.fromJson(listJson[i]));
      }
      radioList = radios;
      emit(RadioSuccessState());
    } catch (e) {
      emit(RadioFailureState(errorMessage: e.toString()));
    }
  }

  final AudioPlayer _player = AudioPlayer();
  int? playingIndex;
  bool isPlaying = false;
  double volume = 1.0; // Default volume (1.0 = 100%)


  Future<void> playPause(int index, String url) async {
    if (playingIndex == index && isPlaying) {
       _player.pause();
      isPlaying = false;
      emit(RadioPausedState());
    } else {
       _player.stop();
      await _player.setUrl(url);
       _player.play();

      playingIndex = index;
      isPlaying = true;
      emit(RadioPlayingState(index));
    }
  }


  Future<void> stop() async {
    await _player.stop();
    isPlaying = false;
    playingIndex = null;
    emit(SoundRadioStoppedState());
  }

  Future<void> setVolume(double newVolume) async {
    volume = newVolume.clamp(0.0, 1.0);
    await _player.setVolume(volume);
    emit(SoundRadioVolumeChangedState(volume));
  }

  Future<void> muteUnmute() async {
    if (volume > 0) {
      await setVolume(0.0);
    } else {
      await setVolume(1.0);
    }
  }

  @override
  Future<void> close() {
    _player.dispose();
    return super.close();
  }
}