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
    return BlocBuilder<RadioCubit, RadioState>(
      builder: (BuildContext context, RadioState state) {
        var cubit = context.read<RadioCubit>();
        List<RadioStation> listRadios = cubit.radioList;

        if (state is RadioLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RadioFailureState) {
          return Text("Error: ${state.errorMessage}");
        }

        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemCount: listRadios.length, // Ensure the correct item count
          itemBuilder: (context, index) {
            return BlocBuilder<RadioCubit, RadioState>(
              buildWhen: (previous, current) =>
                  current is RadioPlayingState || current is RadioPausedState,
              builder: (context, state) {
                return RadioWidget(
                  radioStation: listRadios[index],
                  index: index,
                );
              },
            );
          },
        );
      },
    );
  }
}
