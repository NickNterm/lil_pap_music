import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lil_pap_beats/features/main_feature/presentation/bloc/player/player_bloc.dart';

import '../../../../components/custom_cache_image.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/values.dart';
import '../../../../dependency_injection.dart';
import '../../../loading_feature/domain/entities/song.dart';
import '../../../loading_feature/presentation/bloc/beats_for_placement/beats_for_placement_bloc.dart';
import '../../domain/entities/song_category.dart';

class DopeBeatWidget extends StatelessWidget {
  const DopeBeatWidget({
    super.key,
    required this.beat,
  });

  final Song beat;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) => Expanded(
        child: GestureDetector(
          onTap: () {
            sl<PlayerBloc>().add(
              PlayerEventPlay(
                beat,
                SongCategory.beatsForPlacement,
                '',
              ),
            );
            //   (sl<PlayerBloc>().state as PlayerLoaded)
            //       .player
            //       .audioPlayer
            //       .audioSource.toString();
          },
          child: Container(
            height: 60,
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: kElementColor,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      topLeft: Radius.circular(50),
                    ),
                    child: CustomCachedImage(
                      url:
                          "$baseUrl/beats_for_placement/cover/${beat.toJson()}",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    beat.title,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
