import 'package:dartz/dartz.dart';
import 'package:lil_pap_beats/features/loading_feature/domain/entities/album.dart';

import '../../../../core/failures/Failure.dart';
import '../entities/collaboration.dart';
import '../entities/song.dart';

abstract class LoadingRepository {
  Future<Either<Failure, List<Album>>> getAlbums();
  Future<Either<Failure, List<Collaboration>>> getCollaboration();
  Future<Either<Failure, List<Song>>> getBeatsForPlacement();
  Future<Either<Failure, bool>> getShowIntro();
  Future<Either<Failure, bool>> setShowIntro(bool value);
}
