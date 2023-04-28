import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../constant/colors.dart';
import '../../../loading_feature/domain/entities/song.dart';
import 'beats_for_placement_widget.dart';

class BeatsForPlacementMainPageWidget extends StatelessWidget {
  const BeatsForPlacementMainPageWidget({
    super.key,
    required this.beats,
  });

  final List<Song> beats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              const Text(
                'Beats For Placement',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kElementColor,
                  ),
                  child: const Text(
                    'See all',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            itemCount: min(3, beats.length ~/ 2),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  BeatForPlacementWidget(
                    beat: beats[index * 2],
                  ),
                  const SizedBox(height: 10),
                  BeatForPlacementWidget(
                    beat: beats[index * 2 + 1],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
