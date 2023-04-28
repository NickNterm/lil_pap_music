import 'package:bloc/bloc.dart';
import 'package:lil_pap_beats/features/loading_feature/domain/use_cases/get_collaborations_use_case.dart';
import 'package:meta/meta.dart';

import '../../../../../core/failures/Failure.dart';
import '../../../domain/entities/collaboration.dart';
part 'collaborations_event.dart';
part 'collaborations_state.dart';

class CollaborationsBloc
    extends Bloc<CollaborationsEvent, CollaborationsState> {
  final GetCollaborationsUseCase getCollaborationsUseCase;
  CollaborationsBloc({
    required this.getCollaborationsUseCase,
  }) : super(CollaborationsInitial()) {
    on<CollaborationsEvent>((event, emit) async {
      if (event is GetCollaborationsEvent) {
        emit(CollaborationsLoading());
        final collaborations = await getCollaborationsUseCase();
        collaborations.fold(
          (l) => emit(CollaborationsError(l)),
          (r) => emit(CollaborationsLoaded(r)),
        );
      }
      if (event is UpdateCollaborationsEvent) {
        emit(CollaborationsLoaded(event.collaborations));
      }
    });
  }
}
