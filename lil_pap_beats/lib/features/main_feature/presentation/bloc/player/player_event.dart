part of 'player_bloc.dart';

@immutable
abstract class PlayerEvent {}

class PlayerEventUpdate extends PlayerEvent {
  PlayerEventUpdate(this.player);
  final PlayerData player;
}

class PlayerEventLoad extends PlayerEvent {}

class PlayerEventPlay extends PlayerEvent {
  PlayerEventPlay(this.song, this.category, this.album);
  final SongCategory category;
  final Song song;
  final String album;
}
