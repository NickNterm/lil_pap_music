part of 'albums_bloc.dart';

@immutable
abstract class AlbumsState {}

class AlbumsInitial extends AlbumsState {}

class AlbumsLoading extends AlbumsState {}

class AlbumsLoaded extends AlbumsState {
  final List<Album> albums;

  AlbumsLoaded(this.albums);
}

class AlbumsError extends AlbumsState {
  final Failure failure;

  AlbumsError(this.failure);
}
