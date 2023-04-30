import 'package:dartz/dartz.dart';

import '../../../../core/failures/Failure.dart';
import '../entities/player_data.dart';

abstract class PlayerRepository {
  Future<Either<Failure, void>> update(PlayerData data);
  Future<Either<Failure, PlayerData>> load();
}
