import 'package:dartz/dartz.dart';
import 'package:lil_pap_beats/core/failures/Failure.dart';
import 'package:lil_pap_beats/features/loading_feature/domain/repository/loading_repository.dart';

class SetShowIntroUseCase {
  final LoadingRepository repo;
  SetShowIntroUseCase(this.repo);
  Future<Either<Failure, bool>> call(bool value) {
    return repo.setShowIntro(value);
  }
}
