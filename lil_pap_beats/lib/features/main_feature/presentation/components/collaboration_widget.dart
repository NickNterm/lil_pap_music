import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lil_pap_beats/features/main_feature/domain/entities/song_category.dart';
import 'package:lil_pap_beats/features/main_feature/presentation/bloc/player/player_bloc.dart';

import '../../../../components/custom_cache_image.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/values.dart';
import '../../../../dependency_injection.dart';
import '../../../loading_feature/domain/entities/collaboration.dart';
import '../../../loading_feature/presentation/bloc/collaborations/collaborations_bloc.dart';

class CollaborationWidget extends StatelessWidget {
  const CollaborationWidget({
    super.key,
    required this.collaboration,
  });

  final Collaboration collaboration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        sl<PlayerBloc>().add(
          PlayerEventPlay(
            collaboration.song,
            SongCategory.collaboration,
            '',
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        decoration: const BoxDecoration(
          color: kElementColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(10),
                ),
                child: CustomCachedImage(
                  url: "$baseUrl/collabs/cover/${collaboration.song.toJson()}",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<PlayerBloc, PlayerState>(
                    builder: (context, state) => Text(
                      collaboration.song.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: (state as PlayerLoaded)
                                    .player
                                    .audioPlayer
                                    .currentIndex ==
                                (sl<CollaborationsBloc>().state
                                        as CollaborationsLoaded)
                                    .collaborations
                                    .indexOf(collaboration)
                            ? state.player.songCategory ==
                                    SongCategory.collaboration
                                ? kPrimaryColor
                                : Colors.white
                            : Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    collaboration.collaborators.join(", "),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
