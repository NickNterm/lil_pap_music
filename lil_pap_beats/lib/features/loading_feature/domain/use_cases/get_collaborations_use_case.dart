import 'package:dartz/dartz.dart';

import '../../../../core/failures/Failure.dart';
import '../entities/collaboration.dart';
import '../repository/loading_repository.dart';

class GetCollaborationsUseCase {
  final LoadingRepository repo;

  GetCollaborationsUseCase(this.repo);

  Future<Either<Failure, List<Collaboration>>> call() async {
    return await repo.getCollaboration();
  }
}
