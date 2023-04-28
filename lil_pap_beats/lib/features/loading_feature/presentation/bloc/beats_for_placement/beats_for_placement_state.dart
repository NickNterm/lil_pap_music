part of 'beats_for_placement_bloc.dart';

@immutable
abstract class BeatsForPlacementState {}

class BeatsForPlacementInitial extends BeatsForPlacementState {}

class BeatsForPlacementLoading extends BeatsForPlacementState {}

class BeatsForPlacementLoaded extends BeatsForPlacementState {
  final List<Song> beats;

  BeatsForPlacementLoaded(this.beats);
}

class BeatsForPlacementError extends BeatsForPlacementState {
  final Failure failure;

  BeatsForPlacementError(this.failure);
}
