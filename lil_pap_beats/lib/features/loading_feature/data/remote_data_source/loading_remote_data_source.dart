import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:lil_pap_beats/constant/values.dart';

import '../../../../core/exceptions/exception.dart';
import '../../../../core/functions/functions.dart';
import '../../domain/entities/album.dart';
import '../../domain/entities/collaboration.dart';
import '../../domain/entities/song.dart';
import 'package:http/http.dart' as http;

import '../entities/album_model.dart';
import '../entities/collaboration_model.dart';
import '../entities/song_model.dart';

abstract class LoadingRemoteDataSource {
  Future<List<Album>> getAlbums();
  Future<List<Collaboration>> getCollaboration();
  Future<List<Song>> getBeatsForPlacement();
}

class LoadingRemoteDataSourceImpl extends LoadingRemoteDataSource {
  final http.Client client;

  LoadingRemoteDataSourceImpl({required this.client});
  @override
  Future<List<Album>> getAlbums() async {
    var url = Uri.parse("$baseUrl/albums");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data = data["Albums"];
      List<Album> albums = [];
      for (var album in data) {
        Color color = await getImagePalette(
          CachedNetworkImageProvider(
            "$baseUrl/albums/cover/${album["title"]}",
          ),
        );
        print("Title: ${album["title"]}");
        print("Color: $color");
        album["dominantColor"] = color.value;
        albums.add(AlbumModel.fromJson(album));
      }
      return albums;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Song>> getBeatsForPlacement() async {
    var url = Uri.parse("$baseUrl/beats_for_placement/songs");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Song> songs = [];
      for (var song in data) {
        songs.add(SongModel.fromName(song));
      }
      return songs;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Collaboration>> getCollaboration() async {
    var url = Uri.parse("$baseUrl/collabs/songs");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Collaboration> collaborations = [];
      for (var collaboration in data) {
        collaborations.add(CollaborationModel.fromJson(collaboration));
      }
      return collaborations;
    } else {
      throw ServerException();
    }
  }
}
