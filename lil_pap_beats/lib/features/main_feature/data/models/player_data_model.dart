import 'package:just_audio/just_audio.dart';
import 'package:lil_pap_beats/features/main_feature/domain/entities/player_data.dart';

class PlayerDataModel extends PlayerData {
  const PlayerDataModel({
    required super.audioPlayer,
    required super.isPlaying,
    required super.positionInSeconds,
    required super.isLooping,
    required super.songCategory,
    required super.song,
    required super.clippingStart,
    required super.clippingEnd,
    required super.isShuffling,
    required super.stretchingFactor,
  });

  factory PlayerDataModel.fromJson(Map<String, dynamic> json) {
    return PlayerDataModel(
      audioPlayer: AudioPlayer(),
      isPlaying: json['isPlaying'],
      positionInSeconds: json['positionInSeconds'],
      isLooping: json['isLooping'],
      songCategory: json['songCategory'],
      song: json['song'],
      clippingStart: json['clippingStart'],
      clippingEnd: json['clippingEnd'],
      isShuffling: json['isShuffling'],
      stretchingFactor: json['stretchingFactor'],
    );
  }
}
