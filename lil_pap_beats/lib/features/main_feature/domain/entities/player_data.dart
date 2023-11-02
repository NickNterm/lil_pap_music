import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lil_pap_beats/features/main_feature/domain/entities/song_category.dart';

import '../../../loading_feature/domain/entities/song.dart';

class PlayerData extends Equatable {
  final AudioPlayer audioPlayer;
  final bool isPlaying;
  final int positionInSeconds;
  final bool isLooping;
  final SongCategory songCategory;
  final Song song;
  final int? clippingStart;
  final int? clippingEnd;
  final bool isShuffling;
  final double stretchingFactor;
  final String? album;

  const PlayerData({
    required this.audioPlayer,
    required this.isPlaying,
    required this.positionInSeconds,
    required this.isLooping,
    required this.songCategory,
    required this.song,
    required this.clippingStart,
    required this.clippingEnd,
    required this.isShuffling,
    required this.stretchingFactor,
    required this.album,
  });

  copyWith({
    AudioPlayer? audioPlayer,
    bool? isPlaying,
    int? positionInSeconds,
    bool? isLooping,
    SongCategory? songCategory,
    Song? song,
    int? clippingStart,
    int? clippingEnd,
    bool? isShuffling,
    double? stretchingFactor,
    String? album,
  }) {
    return PlayerData(
      audioPlayer: audioPlayer ?? this.audioPlayer,
      isPlaying: isPlaying ?? this.isPlaying,
      positionInSeconds: positionInSeconds ?? this.positionInSeconds,
      isLooping: isLooping ?? this.isLooping,
      songCategory: songCategory ?? this.songCategory,
      song: song ?? this.song,
      clippingStart: clippingStart ?? this.clippingStart,
      clippingEnd: clippingEnd ?? this.clippingEnd,
      isShuffling: isShuffling ?? this.isShuffling,
      stretchingFactor: stretchingFactor ?? this.stretchingFactor,
      album: album ?? this.album,
    );
  }

  String toJson() {
    return '{'
        '"isPlaying": $isPlaying,'
        '"positionInSeconds": $positionInSeconds,'
        '"isLooping": $isLooping,'
        '"songCategory": $songCategory,'
        '"song": ${song.toJson()},'
        '"clippingStart": $clippingStart,'
        '"clippingEnd": $clippingEnd,'
        '"isShuffling": $isShuffling,'
        '"stretchingFactor": $stretchingFactor'
        '"album": $album'
        '}';
  }

  @override
  List<Object?> get props => [
        isPlaying,
        positionInSeconds,
        isLooping,
        songCategory,
        song,
        clippingStart,
        clippingEnd,
        isShuffling,
        stretchingFactor,
        album,
      ];
}
