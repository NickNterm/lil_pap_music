import 'package:dartz/dartz.dart';
import 'package:lil_pap_beats/features/loading_feature/domain/entities/album.dart';

import '../../../../core/failures/Failure.dart';
import '../repository/loading_repository.dart';

class GetAlbumsUseCase {
  final LoadingRepository repo;

  GetAlbumsUseCase(this.repo);

  Future<Either<Failure, List<Album>>> call() async {
    return await repo.getAlbums();
  }
}
