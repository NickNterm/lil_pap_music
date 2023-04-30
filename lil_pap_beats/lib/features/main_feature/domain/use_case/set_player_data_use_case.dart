import 'package:dartz/dartz.dart';
import 'package:lil_pap_beats/features/main_feature/domain/repository/player_repository.dart';

import '../../../../core/failures/Failure.dart';
import '../entities/player_data.dart';

class SetPlayerDataUseCase {
  final PlayerRepository repo;

  SetPlayerDataUseCase(this.repo);

  Future<Either<Failure, void>> call(PlayerData player) async {
    return await repo.update(player);
  }
}
