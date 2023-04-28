import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lil_pap_beats/constant/values.dart';
import 'package:meta/meta.dart';

import '../../../../../core/failures/Failure.dart';
import '../../../domain/entities/song.dart';
import '../../../domain/use_cases/get_beats_for_placement_use_case.dart';
part 'beats_for_placement_event.dart';
part 'beats_for_placement_state.dart';

class BeatsForPlacementBloc
    extends Bloc<BeatsForPlacementEvent, BeatsForPlacementState> {
  final GetBeatsForPlacementUseCase getBeatsForPlacementUseCase;
  BeatsForPlacementBloc({
    required this.getBeatsForPlacementUseCase,
  }) : super(BeatsForPlacementInitial()) {
    on<BeatsForPlacementEvent>((event, emit) async {
      if (event is GetBeatsForPlacementEvent) {
        emit(BeatsForPlacementLoading());
        final beats = await getBeatsForPlacementUseCase();
        beats.fold(
          (l) => emit(BeatsForPlacementError(l)),
          (r) => emit(BeatsForPlacementLoaded(r)),
        );
      }
      if (event is UpdateBeatsForPlacementEvent) {
        emit(BeatsForPlacementLoaded(event.beats));
      }
    });
  }
}

void updateBeatsForPlacementAudioRoom(List<Song> beats) async {
  AudioPlayer audioPlayer = AudioPlayer();
  await audioPlayer.setAudioSource(
    ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: beats
          .map(
            (e) => AudioSource.uri(
              Uri.parse(
                "$baseUrl/beats_for_placement/songs/${e.toJson()}",
              ),
              tag: MediaItem(
                title: e.title,
                id: '',
              ),
            ),
          )
          .toList(),
    ),
  );
}
