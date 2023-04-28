import 'package:dartz/dartz.dart';
import 'package:lil_pap_beats/features/loading_feature/domain/repository/loading_repository.dart';

import '../../../../core/failures/Failure.dart';

class GetShowIntroUseCase {
  final LoadingRepository repo;

  GetShowIntroUseCase(this.repo);

  Future<Either<Failure, bool>> call() async {
    return await repo.getShowIntro();
  }
}
