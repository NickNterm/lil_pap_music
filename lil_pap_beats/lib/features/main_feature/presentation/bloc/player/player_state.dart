part of 'player_bloc.dart';

@immutable
abstract class PlayerState {}

class PlayerInitial extends PlayerState {}

class PlayerLoading extends PlayerState {}

class PlayerLoaded extends PlayerState {
  PlayerLoaded(this.player);
  final PlayerData player;
}

class PlayerError extends PlayerState {
  PlayerError(this.message);
  final String message;
}
