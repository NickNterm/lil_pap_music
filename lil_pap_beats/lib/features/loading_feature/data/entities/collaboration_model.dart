import 'package:lil_pap_beats/features/loading_feature/data/entities/song_model.dart';

import '../../domain/entities/collaboration.dart';
import '../../domain/entities/song.dart';

class CollaborationModel extends Collaboration {
  const CollaborationModel({
    required List<String> collaborators,
    required Song song,
  }) : super(
          collaborators: collaborators,
          song: song,
        );

  factory CollaborationModel.fromJson(Map<String, dynamic> json) {
    List<String> listCollaborators = [];
    for (var str in json['collab']) {
      listCollaborators.add(str);
    }

    print(json);
    return CollaborationModel(
      collaborators: listCollaborators,
      song: SongModel.fromName(json['name']),
    );
  }
}
