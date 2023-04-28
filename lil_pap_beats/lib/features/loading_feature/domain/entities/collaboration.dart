import 'package:equatable/equatable.dart';
import 'package:lil_pap_beats/features/loading_feature/domain/entities/song.dart';

class Collaboration extends Equatable {
  final List<String> collaborators;
  final Song song;

  const Collaboration({
    required this.collaborators,
    required this.song,
  });

  Map<String, dynamic> toJson() {
    return {
      'collab': collaborators,
      'name': song.toJson(),
    };
  }

  @override
  List<Object?> get props => [collaborators, song];
}
