import 'package:dartz/dartz.dart';
import 'package:lil_pap_beats/features/main_feature/domain/entities/player_data.dart';

import '../../../../core/failures/Failure.dart';
import '../repository/player_repository.dart';

class GetPlayerDataUseCase {
  final PlayerRepository playerRepository;

  GetPlayerDataUseCase(this.playerRepository);

  Future<Either<Failure, PlayerData>> call() async {
    return await playerRepository.load();
  }
}
