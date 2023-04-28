import 'package:lil_pap_beats/features/loading_feature/data/entities/song_model.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/song.dart';

class AlbumModel extends Album {
  const AlbumModel({
    required String title,
    required List<Song> songs,
  }) : super(
          title: title,
          songs: songs,
        );

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    List<Song> listSongs = json['songs']
        .map<Song>(
          (song) => SongModel.fromName(song),
        )
        .toList();
    return AlbumModel(
      title: json['title'],
      songs: listSongs,
    );
  }
}
