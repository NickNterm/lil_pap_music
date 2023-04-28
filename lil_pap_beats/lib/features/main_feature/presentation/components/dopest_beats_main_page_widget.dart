import 'package:flutter/material.dart';

import '../../../loading_feature/domain/entities/song.dart';
import 'dope_beat_widget.dart';

class DopestBeatsMainPageWidget extends StatelessWidget {
  const DopestBeatsMainPageWidget({
    super.key,
    required this.beats,
  });

  final List<Song> beats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              'Dopest Beats',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              DopeBeatWidget(beat: beats[0]),
              DopeBeatWidget(beat: beats[1]),
            ],
          ),
          Row(
            children: [
              DopeBeatWidget(beat: beats[2]),
              DopeBeatWidget(beat: beats[3]),
            ],
          ),
          Row(
            children: [
              DopeBeatWidget(beat: beats[4]),
              DopeBeatWidget(beat: beats[5]),
            ],
          ),
        ],
      ),
    );
  }
}
