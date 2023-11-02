import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lil_pap_beats/components/custom_cache_image.dart';
import 'package:lil_pap_beats/constant/values.dart';

import '../../../../constant/colors.dart';
import '../../../../dependency_injection.dart';
import '../../../loading_feature/domain/entities/song.dart';
import '../../../loading_feature/presentation/bloc/beats_for_placement/beats_for_placement_bloc.dart';
import '../../domain/entities/song_category.dart';
import '../bloc/player/player_bloc.dart';

class BeatForPlacementWidget extends StatelessWidget {
  final Song beat;

  const BeatForPlacementWidget({
    super.key,
    required this.beat,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        sl<PlayerBloc>().add(
          PlayerEventPlay(
            beat,
            SongCategory.beatsForPlacement,
            '',
          ),
        );
      },
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kElementColor,
        ),
        child: Row(
          children: [
            Container(
              height: 55,
              width: 55,
              margin: const EdgeInsets.all(7.5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CustomCachedImage(
                  url: "$baseUrl/beats_for_placement/cover/${beat.toJson()}",
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: BlocBuilder<PlayerBloc, PlayerState>(
                builder: (context, state) => Text(
                  beat.title,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: (state as PlayerLoaded)
                                .player
                                .audioPlayer
                                .currentIndex ==
                            (sl<BeatsForPlacementBloc>().state
                                    as BeatsForPlacementLoaded)
                                .beats
                                .indexOf(beat)
                        ? state.player.songCategory ==
                                SongCategory.beatsForPlacement
                            ? kPrimaryColor
                            : Colors.white
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
