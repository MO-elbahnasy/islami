import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:islamy/home/model/radio_model.dart';

class RadioWidget extends StatelessWidget {
  final RadioStation radioStation;
  const RadioWidget({super.key, required this.radioStation});

  @override
  Widget build(BuildContext context) {
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
              "${radioStation.name}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 20,
              ),
            ),
             const SizedBox(
              height: 24,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  size: 32,
                ),
                SizedBox(
                  width: 12,
                ),
                IconButton(

                  onPressed: () async{
                    final player = AudioPlayer();
                    await player.play(UrlSource(radioStation.url??""));

                  }, icon: Icon(
                  Icons.play_arrow,
                  size: 32,
                ),
                ),
                SizedBox(
                  width: 12,
                ),
                Icon(
                  Icons.volume_down_sharp,
                  size: 32,
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}

