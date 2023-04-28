part of 'beats_for_placement_bloc.dart';

@immutable
abstract class BeatsForPlacementEvent {}

class GetBeatsForPlacementEvent extends BeatsForPlacementEvent {}

class UpdateBeatsForPlacementEvent extends BeatsForPlacementEvent {
  final List<Song> beats;

  UpdateBeatsForPlacementEvent(this.beats);
}
