part of 'collaborations_bloc.dart';

@immutable
abstract class CollaborationsEvent {}

class GetCollaborationsEvent extends CollaborationsEvent {}

class UpdateCollaborationsEvent extends CollaborationsEvent {
  final List<Collaboration> collaborations;

  UpdateCollaborationsEvent(this.collaborations);
}
