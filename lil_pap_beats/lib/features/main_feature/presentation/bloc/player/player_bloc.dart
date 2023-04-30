import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
        emit(PlayerLoading());
        var result = await getPlayerDataUseCase();
        result.fold(
          (failure) => emit(PlayerError(failure.message)),
          (player) => emit(PlayerLoaded(player)),
        );
      }
      if (event is PlayerEventUpdate) {
        emit(PlayerLoading());
        var result = await setPlayerDataUseCase(event.player);
        result.fold(
          (failure) => emit(PlayerError(failure.message)),
          (_) => emit(PlayerLoaded(event.player)),
        );
      }
    });
  }
}
