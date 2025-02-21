
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamy/home/model/radio_model.dart';
import 'package:islamy/home/view_model/radio/radio_cubit.dart';
import 'package:islamy/home/view_model/radio/radio_state.dart';
import 'package:islamy/home/widgets/radio_widget.dart';

class ListRadioWidget extends StatelessWidget {
  const ListRadioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<RadioCubit>(context);
    return
      BlocBuilder<RadioCubit, RadioState>
        (builder: (BuildContext context, RadioState state) {
          List<RadioStation> listRadios=cubit.radioList;
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 12,
            ),
            itemBuilder: (context, index) {
              if (state is RadioLoadingState){
                return  const Center(child: CircularProgressIndicator());
              } else if (state is RadioSuccessState){
                return  RadioWidget(radioStation: listRadios[index],);
              } else if (state is RadioFailureState){
                return Text("Error : ${state.errorMessage}");
              } else{
                return const SizedBox();
              }
            },
            itemCount: 20,
          );
      },
      );

  }
}
