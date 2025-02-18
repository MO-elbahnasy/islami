abstract class RadioState{}
class RadioStateInitialState extends RadioState{}
class RadioLoadingState  extends RadioState{}
class RadioSuccessState extends RadioState{}
class RadioFailureState extends RadioState{
  final String errorMessage;

  RadioFailureState({required this.errorMessage});
}
