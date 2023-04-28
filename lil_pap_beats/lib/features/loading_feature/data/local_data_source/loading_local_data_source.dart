import 'dart:convert';

import 'package:lil_pap_beats/constant/shared_pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/collaboration.dart';
import '../../domain/entities/song.dart';
import '../entities/album_model.dart';
import '../entities/collaboration_model.dart';
import '../entities/song_model.dart';

abstract class LoadingLocalDataSource {
  Future<List<Album>> getAlbums();
  Future<bool> cacheAlbums(List<Album> albums);
  Future<List<Collaboration>> getCollaboration();
  Future<bool> cacheCollaboration(List<Collaboration> collaborations);
  Future<List<Song>> getBeatsForPlacement();
  Future<bool> cacheBeatsForPlacement(List<Song> songs);
  Future<bool> getShowIntro();
  Future<bool> cacheShowIntro(bool showIntro);
}

class LoadingLocalDataSourceImpl extends LoadingLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoadingLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> cacheAlbums(List<Album> albums) {
    List<String> listAlbums = [];
    for (var album in albums) {
      listAlbums.add(jsonEncode(album.toJson()));
    }
    return sharedPreferences.setStringList(
      albumsKey,
      listAlbums,
    );
  }

  @override
  Future<bool> cacheBeatsForPlacement(List<Song> songs) {
    List<String> listSongs = [];
    for (var song in songs) {
      listSongs.add(song.toJson());
    }
    return sharedPreferences.setStringList(
      beatsForPlacementKey,
      listSongs,
    );
  }

  @override
  Future<bool> cacheCollaboration(List<Collaboration> collaborations) {
    List<String> listCollaborations = [];
    for (var collaboration in collaborations) {
      listCollaborations.add(jsonEncode(collaboration.toJson()));
    }
    return sharedPreferences.setStringList(
      collaborationsKey,
      listCollaborations,
    );
  }

  @override
  Future<List<Album>> getAlbums() {
    List<Album> albums = [];
    List<String> albumsString =
        sharedPreferences.getStringList(albumsKey) ?? [];
    for (var album in albumsString) {
      albums.add(AlbumModel.fromJson(jsonDecode(album)));
    }
    return Future.value(albums);
  }

  @override
  Future<List<Song>> getBeatsForPlacement() {
    List<Song> songs = [];
    List<String> songsString =
        sharedPreferences.getStringList(beatsForPlacementKey) ?? [];
    for (var song in songsString) {
      songs.add(SongModel.fromName(song));
    }
    return Future.value(songs);
  }

  @override
  Future<List<Collaboration>> getCollaboration() {
    List<Collaboration> collaborations = [];
    List<String> collaborationsString =
        sharedPreferences.getStringList(collaborationsKey) ?? [];
    for (var collaboration in collaborationsString) {
      collaborations
          .add(CollaborationModel.fromJson(jsonDecode(collaboration)));
    }
    return Future.value(collaborations);
  }

  @override
  Future<bool> cacheShowIntro(bool showIntro) {
    return sharedPreferences.setBool(
      showIntroKey,
      showIntro,
    );
  }

  @override
  Future<bool> getShowIntro() {
    return Future.value(
      sharedPreferences.getBool(showIntroKey) ?? true,
    );
  }
}
