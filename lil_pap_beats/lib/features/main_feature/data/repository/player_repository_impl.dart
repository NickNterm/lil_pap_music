import 'package:dartz/dartz.dart';
import 'package:lil_pap_beats/core/failures/Failure.dart';
import 'package:lil_pap_beats/features/main_feature/domain/entities/player_data.dart';

import '../../domain/repository/player_repository.dart';
import '../main_local_data/main_local_data.dart';

class PlayerRepositoryImpl extends PlayerRepository {
  final MainLocalDataSource localDataSource;

  PlayerRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, PlayerData>> load() async {
    try {
      final playerData = await localDataSource.getPlayerData();
      return Right(playerData);
    } catch (e) {
      return Left(CacheFailure(message: ''));
    }
  }

  @override
  Future<Either<Failure, void>> update(PlayerData data) async {
    try {
      await localDataSource.setPlayerData(data);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: ''));
    }
  }
}
