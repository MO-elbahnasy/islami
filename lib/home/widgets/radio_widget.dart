import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:islamy/home/model/radio_model.dart';

class RadioWidget extends StatefulWidget {
  final RadioStation radioStation;

  const RadioWidget({super.key, required this.radioStation});

  @override
  _RadioWidgetState createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  bool _isLoading = false; // Show loading indicator when buffering

  @override
  void initState() {
    super.initState();
    _setupAudio();
  }

  Future<void> _setupAudio() async {
    if (widget.radioStation.url != null && widget.radioStation.url!.isNotEmpty) {
      await _player.setSourceUrl(
        widget.radioStation.url!,

      );
    }
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _player.pause();
      setState(() => _isPlaying = false);
    } else {
      setState(() => _isLoading = true); // Show loading indicator
      try {
        await _player.resume();
        setState(() {
          _isPlaying = true;
          _isLoading = false; // Hide loading indicator
        });
      } catch (e) {
        setState(() => _isLoading = false);
        print("Error playing audio: $e");
      }
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

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
              widget.radioStation.name??"",
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
                  onPressed: _togglePlayPause,
                  icon: _isLoading
                      ? const CircularProgressIndicator() // Show loading indicator
                      : Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
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
  }
}
