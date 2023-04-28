import 'package:equatable/equatable.dart';
import 'package:lil_pap_beats/features/loading_feature/domain/entities/song.dart';

class Album extends Equatable {
  final String title;
  final List<Song> songs;

  const Album({
    required this.title,
    required this.songs,
  });

  Map<String, dynamic> toJson() {
    List<String> listSongs = songs.map((song) => song.toJson()).toList();
    return {
      'title': title,
      'songs': listSongs,
    };
  }

  @override
  List<Object?> get props => [title, songs];
}
