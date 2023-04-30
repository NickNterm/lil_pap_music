part of 'player_bloc.dart';

@immutable
abstract class PlayerEvent {}

class PlayerEventUpdate extends PlayerEvent {
  PlayerEventUpdate(this.player);
  final PlayerData player;
}

class PlayerEventLoad extends PlayerEvent {}
