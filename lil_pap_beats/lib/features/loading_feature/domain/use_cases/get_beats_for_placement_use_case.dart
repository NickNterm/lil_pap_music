import 'package:dartz/dartz.dart';

import '../../../../core/failures/Failure.dart';
import '../entities/song.dart';
import '../repository/loading_repository.dart';

class GetBeatsForPlacementUseCase {
  final LoadingRepository repo;

  GetBeatsForPlacementUseCase(this.repo);

  Future<Either<Failure, List<Song>>> call() async {
    return await repo.getBeatsForPlacement();
  }
}
