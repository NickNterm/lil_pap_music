import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/use_cases/get_show_intro_use_case.dart';
import '../../../domain/use_cases/set_show_intro_use_case.dart';
part 'show_intro_state.dart';

class ShowIntroCubit extends Cubit<ShowIntroState> {
  final GetShowIntroUseCase getShowIntroUseCase;
  final SetShowIntroUseCase setShowIntroUseCase;
  ShowIntroCubit({
    required this.getShowIntroUseCase,
    required this.setShowIntroUseCase,
  }) : super(ShowIntroInitial());

  void getShowIntro() async {
    emit(ShowIntroLoading());
    final result = await getShowIntroUseCase();
    result.fold(
      (failure) => emit(ShowIntroLoaded(false)),
      (showIntro) => emit(ShowIntroLoaded(showIntro)),
    );
  }

  void setShowIntro(bool value) async {
    emit(ShowIntroLoading());
    final result = await setShowIntroUseCase(value);
    result.fold(
      (failure) => emit(ShowIntroLoaded(value)),
      (showIntro) => emit(ShowIntroLoaded(showIntro)),
    );
  }
}
