import 'package:dartz/dartz.dart';
import 'package:flutter/gestures.dart';
import 'package:lil_pap_beats/core/failures/Failure.dart';
import 'package:lil_pap_beats/features/loading_feature/domain/entities/album.dart';
import 'package:lil_pap_beats/features/loading_feature/domain/entities/collaboration.dart';
import 'package:lil_pap_beats/features/loading_feature/domain/entities/song.dart';
import 'package:lil_pap_beats/features/loading_feature/presentation/bloc/collaborations/collaborations_bloc.dart';

import '../../../../core/exceptions/exception.dart';
import '../../../../core/network_info/network_info.dart';
import '../../../../dependency_injection.dart';
import '../../domain/repository/loading_repository.dart';
import '../../presentation/bloc/albums/albums_bloc.dart';
import '../../presentation/bloc/beats_for_placement/beats_for_placement_bloc.dart';
import '../local_data_source/loading_local_data_source.dart';
import '../remote_data_source/loading_remote_data_source.dart';

class LoadingRepositoryImpl implements LoadingRepository {
  final LoadingRemoteDataSource remoteDataSource;
  final LoadingLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LoadingRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Album>>> getAlbums() async {
    try {
      final localAlbums = await localDataSource.getAlbums();
      if (localAlbums.isNotEmpty) {
        if (await networkInfo.isConnected) {
          remoteDataSource.getAlbums().then((value) async {
            await localDataSource.cacheAlbums(value);
            sl<AlbumsBloc>().add(UpdateAlbumsEvent(value));
          });
        }
        return Right(localAlbums);
      } else {
        if (await networkInfo.isConnected) {
          final remoteAlbums = await remoteDataSource.getAlbums();
          await localDataSource.cacheAlbums(remoteAlbums);
          return Right(remoteAlbums);
        } else {
          return Left(ServerFailure(message: "No Internet Connection"));
        }
      }
    } on ServerException catch (_) {
      return Left(ServerFailure(message: "Error Loading Albums"));
    } on CacheException catch (_) {
      return Left(CacheFailure(message: "Error Loading Albums From Cache"));
    }
  }

  @override
  Future<Either<Failure, List<Song>>> getBeatsForPlacement() async {
    try {
      final localBeats = await localDataSource.getBeatsForPlacement();
      if (localBeats.isNotEmpty) {
        if (await networkInfo.isConnected) {
          remoteDataSource.getBeatsForPlacement().then((value) async {
            await localDataSource.cacheBeatsForPlacement(value);
            sl<BeatsForPlacementBloc>()
                .add(UpdateBeatsForPlacementEvent(value));
          });
        }
        return Right(localBeats);
      } else {
        if (await networkInfo.isConnected) {
          final remoteBeats = await remoteDataSource.getBeatsForPlacement();
          await localDataSource.cacheBeatsForPlacement(remoteBeats);
          return Right(remoteBeats);
        } else {
          return Left(ServerFailure(message: "No Internet Connection"));
        }
      }
    } on ServerException catch (_) {
      return Left(ServerFailure(message: "Error Loading Beats"));
    } on CacheException catch (_) {
      return Left(CacheFailure(message: "Error Loading Beats From Cache"));
    }
  }

  @override
  Future<Either<Failure, List<Collaboration>>> getCollaboration() async {
    try {
      final localCollaborations = await localDataSource.getCollaboration();
      if (localCollaborations.isNotEmpty) {
        if (await networkInfo.isConnected) {
          remoteDataSource.getCollaboration().then((value) async {
            await localDataSource.cacheCollaboration(value);
            sl<CollaborationsBloc>().add(UpdateCollaborationsEvent(value));
          });
        }
        return Right(localCollaborations);
      } else {
        if (await networkInfo.isConnected) {
          final remoteCollaborations =
              await remoteDataSource.getCollaboration();
          await localDataSource.cacheCollaboration(remoteCollaborations);
          return Right(remoteCollaborations);
        } else {
          return Left(ServerFailure(message: "No Internet Connection"));
        }
      }
    } on ServerException catch (_) {
      return Left(ServerFailure(message: "Error Loading Collaborations"));
    } on CacheException catch (_) {
      return Left(
          CacheFailure(message: "Error Loading Collaborations From Cache"));
    }
  }

  @override
  Future<Either<Failure, bool>> getShowIntro() async {
    try {
      final localShowIntro = await localDataSource.getShowIntro();
      return Right(localShowIntro);
    } on CacheException catch (_) {
      return Left(CacheFailure(message: "Error Loading Intro From Cache"));
    }
  }

  @override
  Future<Either<Failure, bool>> setShowIntro(bool showIntro) async {
    try {
      final localShowIntro = await localDataSource.cacheShowIntro(showIntro);
      return Right(localShowIntro);
    } on CacheException catch (_) {
      return Left(CacheFailure(message: "Error Loading Intro From Cache"));
    }
  }
}
