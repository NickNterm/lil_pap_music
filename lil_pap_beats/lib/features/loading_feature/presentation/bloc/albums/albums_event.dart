part of 'albums_bloc.dart';

@immutable
abstract class AlbumsEvent {}

class GetAlbumsEvent extends AlbumsEvent {}

class UpdateAlbumsEvent extends AlbumsEvent {
  final List<Album> albums;

  UpdateAlbumsEvent(this.albums);
}
