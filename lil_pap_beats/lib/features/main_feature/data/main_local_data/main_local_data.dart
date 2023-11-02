import 'dart:convert';

import 'package:just_audio/just_audio.dart';
import 'package:lil_pap_beats/constant/shared_pref_keys.dart';
import 'package:lil_pap_beats/features/main_feature/domain/entities/player_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../loading_feature/domain/entities/song.dart';
import '../../domain/entities/song_category.dart';
import '../models/player_data_model.dart';

abstract class MainLocalDataSource {
  Future<PlayerData> getPlayerData();
  Future<bool> setPlayerData(PlayerData data);
}

class MainLocalDataSourceImpl implements MainLocalDataSource {
  final SharedPreferences sharedPreferences;
  MainLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<PlayerData> getPlayerData() async {
    final jsonString = sharedPreferences.getString(playerDateKey);
    if (jsonString != null) {
      try {
        print(jsonDecode(jsonString));
        return Future.value(PlayerDataModel.fromJson(jsonDecode(jsonString)));
      } catch (e) {
        print(e);
        return Future.value(
          PlayerData(
            audioPlayer: AudioPlayer(),
            isPlaying: false,
            positionInSeconds: 0,
            isLooping: false,
            songCategory: SongCategory.album,
            song: const Song(
              title: '',
              fileType: '',
            ),
            clippingStart: 0,
            clippingEnd: 0,
            isShuffling: false,
            stretchingFactor: 0,
            album: '',
          ),
        );
      }
    } else {
      return Future.value(
        PlayerData(
          audioPlayer: AudioPlayer(),
          isPlaying: false,
          positionInSeconds: 0,
          isLooping: false,
          songCategory: SongCategory.album,
          song: const Song(
            title: '',
            fileType: '',
          ),
          clippingStart: 0,
          clippingEnd: 0,
          isShuffling: false,
          stretchingFactor: 0,
          album: '',
        ),
      );
    }
  }

  @override
  Future<bool> setPlayerData(PlayerData data) async {
    return sharedPreferences.setString(
      playerDateKey,
      jsonEncode(data.toJson()),
    );
  }
}
