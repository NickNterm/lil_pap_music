part of 'show_intro_cubit.dart';

@immutable
abstract class ShowIntroState {}

class ShowIntroInitial extends ShowIntroState {}

class ShowIntroLoading extends ShowIntroState {}

class ShowIntroLoaded extends ShowIntroState {
  final bool showIntro;

  ShowIntroLoaded(this.showIntro);
}
