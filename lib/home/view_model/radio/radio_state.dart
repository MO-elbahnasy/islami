abstract class RadioState{}
class RadioStateInitialState extends RadioState{}
class RadioLoadingState  extends RadioState{}
class RadioSuccessState extends RadioState{}
class RadioStateUpdated extends RadioState{}
class RadioFailureState extends RadioState{
  final String errorMessage;

  RadioFailureState({required this.errorMessage});
}

class RadioPlayingState extends RadioState {
  final int index;
  RadioPlayingState(this.index);
}


class RadioPausedState extends RadioState {}

class SoundRadioStoppedState extends RadioState {}

class SoundRadioVolumeChangedState extends RadioState {
  final double volume;
  SoundRadioVolumeChangedState(this.volume);
}