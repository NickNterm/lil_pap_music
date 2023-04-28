import 'package:lil_pap_beats/features/loading_feature/domain/entities/song.dart';

class SongModel extends Song {
  const SongModel({
    required String title,
    required String fileType,
  }) : super(
          title: title,
          fileType: fileType,
        );
  factory SongModel.fromName(String name) {
    return SongModel(
      title: name.split(".")[0],
      fileType: name.split(".")[1],
    );
  }
}
