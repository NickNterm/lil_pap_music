import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:lil_pap_beats/features/loading_feature/domain/use_cases/get_show_intro_use_case.dart';
import 'package:lil_pap_beats/features/loading_feature/presentation/cubit/show_intro/show_intro_cubit.dart';
import 'package:lil_pap_beats/features/main_feature/domain/repository/player_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network_info/network_info.dart';
import 'features/loading_feature/data/local_data_source/loading_local_data_source.dart';
import 'features/loading_feature/data/remote_data_source/loading_remote_data_source.dart';
import 'features/loading_feature/data/repository/loading_repository_impl.dart';
import 'features/loading_feature/domain/repository/loading_repository.dart';
import 'features/loading_feature/domain/use_cases/get_albums_use_case.dart';
import 'features/loading_feature/domain/use_cases/get_beats_for_placement_use_case.dart';
import 'features/loading_feature/domain/use_cases/get_collaborations_use_case.dart';
import 'features/loading_feature/domain/use_cases/set_show_intro_use_case.dart';
import 'features/loading_feature/presentation/bloc/albums/albums_bloc.dart';
import 'features/loading_feature/presentation/bloc/beats_for_placement/beats_for_placement_bloc.dart';
import 'features/loading_feature/presentation/bloc/collaborations/collaborations_bloc.dart';
import 'features/main_feature/data/main_local_data/main_local_data.dart';
import 'features/main_feature/data/repository/player_repository_impl.dart';
import 'features/main_feature/domain/use_case/get_player_data_use_case.dart';
import 'features/main_feature/domain/use_case/set_player_data_use_case.dart';
import 'features/main_feature/presentation/bloc/player/player_bloc.dart';
import 'features/main_feature/presentation/cubit/main_page_index/main_page_index_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Loading
  // Bloc
  sl.registerLazySingleton<AlbumsBloc>(
    () => AlbumsBloc(
      getAlbumsUseCase: sl(),
    ),
  );

  sl.registerLazySingleton<PlayerBloc>(
    () => PlayerBloc(
      getPlayerDataUseCase: sl(),
      setPlayerDataUseCase: sl(),
    ),
  );

  sl.registerLazySingleton<BeatsForPlacementBloc>(
    () => BeatsForPlacementBloc(
      getBeatsForPlacementUseCase: sl(),
    ),
  );

  sl.registerLazySingleton<CollaborationsBloc>(
    () => CollaborationsBloc(
      getCollaborationsUseCase: sl(),
    ),
  );

  // Cubit
  sl.registerLazySingleton<ShowIntroCubit>(
    () => ShowIntroCubit(
      getShowIntroUseCase: sl(),
      setShowIntroUseCase: sl(),
    ),
  );

  sl.registerLazySingleton<MainPageIndexCubit>(
    () => MainPageIndexCubit(),
  );

  // Repository
  sl.registerLazySingleton<LoadingRepository>(
    () => LoadingRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<PlayerRepository>(
    () => PlayerRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<LoadingRemoteDataSource>(
    () => LoadingRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<LoadingLocalDataSource>(
    () => LoadingLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<MainLocalDataSource>(
    () => MainLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton<GetAlbumsUseCase>(
    () => GetAlbumsUseCase(sl()),
  );

  sl.registerLazySingleton<GetPlayerDataUseCase>(
    () => GetPlayerDataUseCase(sl()),
  );

  sl.registerLazySingleton<SetPlayerDataUseCase>(
    () => SetPlayerDataUseCase(sl()),
  );

  sl.registerLazySingleton<GetBeatsForPlacementUseCase>(
    () => GetBeatsForPlacementUseCase(sl()),
  );

  sl.registerLazySingleton<GetCollaborationsUseCase>(
    () => GetCollaborationsUseCase(sl()),
  );

  sl.registerLazySingleton<GetShowIntroUseCase>(
    () => GetShowIntroUseCase(sl()),
  );

  sl.registerLazySingleton<SetShowIntroUseCase>(
    () => SetShowIntroUseCase(sl()),
  );

  // Core
  // Network info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectivity: sl(),
    ),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<http.Client>(() => http.Client());
}
