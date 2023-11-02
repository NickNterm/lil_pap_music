import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lil_pap_beats/features/loading_feature/presentation/bloc/beats_for_placement/beats_for_placement_bloc.dart';
import 'package:lil_pap_beats/features/main_feature/domain/entities/song_category.dart';
import 'package:meta/meta.dart';

import '../../../../../constant/values.dart';
import '../../../../../dependency_injection.dart';
import '../../../../loading_feature/domain/entities/song.dart';
import '../../../../loading_feature/presentation/bloc/albums/albums_bloc.dart';
import '../../../../loading_feature/presentation/bloc/collaborations/collaborations_bloc.dart';
import '../../../domain/entities/player_data.dart';
import '../../../domain/use_case/get_player_data_use_case.dart';
import '../../../domain/use_case/set_player_data_use_case.dart';
part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final GetPlayerDataUseCase getPlayerDataUseCase;
  final SetPlayerDataUseCase setPlayerDataUseCase;
  PlayerBloc({
    required this.getPlayerDataUseCase,
    required this.setPlayerDataUseCase,
  }) : super(PlayerInitial()) {
    on<PlayerEvent>((event, emit) async {
      if (event is PlayerEventLoad) {
        var result = await getPlayerDataUseCase();
        result.fold(
          (failure) => emit(PlayerError(failure.message)),
          (player) => emit(PlayerLoaded(player)),
        );
      }
      if (event is PlayerEventUpdate) {
        var result = await setPlayerDataUseCase(event.player);
        result.fold(
          (failure) => emit(PlayerLoaded(event.player)),
          (_) => emit(PlayerLoaded(event.player)),
        );
      }
      if (event is PlayerEventPlay) {
        if ((state as PlayerLoaded).player.audioPlayer.playing) {
          (state as PlayerLoaded).player.audioPlayer.stop();
        }
        var player = (state as PlayerLoaded).player;
        List<AudioSource> audioSources = [];
        int index = 0;
        if (event.category == SongCategory.album) {
          var album =
              (sl<AlbumsBloc>().state as AlbumsLoaded).albums.firstWhere(
                    (element) => element.title == event.album,
                  );
          player = player.copyWith(
            album: album.title,
          );
          for (var song in album.songs) {
            if (song.title == event.song.title) {
              index = album.songs.indexOf(song);
            }
            var mediaItem = MediaItem(
              title: song.title,
              genre: "Banger",
              album: album.title,
              id: song.toJson(),
            );
            audioSources.add(
              AudioSource.uri(
                Uri.parse(
                  getSongUrl(
                    event.category,
                    song,
                    album.title,
                  ),
                ),
                tag: mediaItem,
              ),
            );
          }
        } else if (event.category == SongCategory.collaboration) {
          var collabs = (sl<CollaborationsBloc>().state as CollaborationsLoaded)
              .collaborations;
          for (var collab in collabs) {
            if (collab.song.title == event.song.title) {
              index = collabs.indexOf(collab);
            }
            var mediaItem = MediaItem(
              title: collab.song.title,
              genre: "Banger",
              artist: collab.collaborators.join(", "),
              id: collab.song.toJson(),
            );
            audioSources.add(
              AudioSource.uri(
                Uri.parse(
                  getSongUrl(
                    event.category,
                    collab.song,
                    null,
                  ),
                ),
                tag: mediaItem,
              ),
            );
          }
        } else if (event.category == SongCategory.beatsForPlacement) {
          var beats =
              (sl<BeatsForPlacementBloc>().state as BeatsForPlacementLoaded)
                  .beats;
          for (var song in beats) {
            if (song.title == event.song.title) {
              index = beats.indexOf(song);
            }
            var mediaItem = MediaItem(
              title: song.title,
              genre: "Banger",
              album: "Beats for placement",
              id: song.toJson(),
            );
            audioSources.add(
              AudioSource.uri(
                Uri.parse(
                  getSongUrl(
                    event.category,
                    song,
                    null,
                  ),
                ),
                tag: mediaItem,
              ),
            );
          }
        }
        var playlist = ConcatenatingAudioSource(
          useLazyPreparation: true,
          children: audioSources,
        );

        await player.audioPlayer.setAudioSource(
          playlist,
          initialIndex: index,
          initialPosition: Duration.zero,
        );

        player = player.copyWith(
          song: event.song,
          songCategory: event.category,
          isPlaying: true,
        );
        player.audioPlayer.play();

        player.audioPlayer.currentIndexStream.listen((index) {
          if (index != null) {
            var player = (state as PlayerLoaded).player;
            if (player.songCategory == SongCategory.album) {
              var album =
                  (sl<AlbumsBloc>().state as AlbumsLoaded).albums.firstWhere(
                        (element) => element.title == player.album,
                      );
              player = player.copyWith(
                song: album.songs[index],
              );
            } else if (player.songCategory == SongCategory.collaboration) {
              var collabs =
                  (sl<CollaborationsBloc>().state as CollaborationsLoaded)
                      .collaborations;
              player = player.copyWith(
                song: collabs[index].song,
              );
            } else if (player.songCategory == SongCategory.beatsForPlacement) {
              var beats =
                  (sl<BeatsForPlacementBloc>().state as BeatsForPlacementLoaded)
                      .beats;
              player = player.copyWith(
                song: beats[index],
              );
            }
            add(PlayerEventUpdate(player));
          }
        });
        emit(PlayerLoaded(player));
      }
    });
  }
}

String getSongUrl(SongCategory category, Song song, String? album) {
  switch (category) {
    case SongCategory.album:
      return '$baseUrl/albums/songs/${album!}/${song.toJson()}';
    case SongCategory.beatsForPlacement:
      return '$baseUrl/beats_for_placement/songs/${song.toJson()}';
    case SongCategory.collaboration:
      return '$baseUrl/collabs/songs/${song.toJson()}';
  }
}

String getSongCoverUrl(SongCategory category, Song song, String? album) {
  switch (category) {
    case SongCategory.album:
      return '$baseUrl/albums/cover/${album!}';
    case SongCategory.beatsForPlacement:
      return '$baseUrl/beats_for_placement/cover/${song.toJson()}';
    case SongCategory.collaboration:
      return '$baseUrl/collabs/cover/${song.toJson()}';
  }
}
