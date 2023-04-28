import 'package:bloc/bloc.dart';
import 'package:lil_pap_beats/features/loading_feature/domain/use_cases/get_albums_use_case.dart';
import 'package:meta/meta.dart';

import '../../../../../core/failures/Failure.dart';
import '../../../domain/entities/album.dart';

part 'albums_event.dart';
part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  final GetAlbumsUseCase getAlbumsUseCase;
  AlbumsBloc({required this.getAlbumsUseCase}) : super(AlbumsInitial()) {
    on<AlbumsEvent>((event, emit) async {
      if (event is GetAlbumsEvent) {
        emit(AlbumsLoading());
        final albums = await getAlbumsUseCase();
        albums.fold(
          (l) => emit(AlbumsError(l)),
          (r) => emit(AlbumsLoaded(r)),
        );
      }
      if (event is UpdateAlbumsEvent) {
        emit(AlbumsLoaded(event.albums));
      }
    });
  }
}
