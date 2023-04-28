part of 'collaborations_bloc.dart';

@immutable
abstract class CollaborationsState {}

class CollaborationsInitial extends CollaborationsState {}

class CollaborationsLoading extends CollaborationsState {}

class CollaborationsLoaded extends CollaborationsState {
  final List<Collaboration> collaborations;

  CollaborationsLoaded(this.collaborations);
}

class CollaborationsError extends CollaborationsState {
  final Failure failure;

  CollaborationsError(this.failure);
}
