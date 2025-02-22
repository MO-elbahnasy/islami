import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamy/home/model/radio_model.dart';
import 'package:just_audio/just_audio.dart';

import '../view_model/radio/radio_cubit.dart';
import '../view_model/radio/radio_state.dart';

class RadioWidget extends StatelessWidget {
  final RadioStation radioStation;
  final int index;

  const RadioWidget({super.key, required this.radioStation, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadioCubit, RadioState>(
      buildWhen: (previous, current) => current is RadioPlayingState || current is RadioPausedState,
      builder: (context, state) {
        var radioCubit = context.read<RadioCubit>();

        return Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/reciters_bg.png",
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Text(
                  radioStation.name ?? "",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite, size: 32),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () {
                        radioCubit.playPause(index, radioStation.url ?? "");
                      },
                      icon: Icon(
                        (radioCubit.playingIndex == index && radioCubit.isPlaying)
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.volume_down_sharp, size: 32),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

