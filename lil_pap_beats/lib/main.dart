import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lil_pap_beats/constant/colors.dart';
import 'package:lil_pap_beats/features/loading_feature/presentation/bloc/beats_for_placement/beats_for_placement_bloc.dart';

import 'dependency_injection.dart';
import 'features/intro_feature/presentation/page/intro_page.dart';
import 'features/loading_feature/presentation/bloc/albums/albums_bloc.dart';
import 'features/loading_feature/presentation/bloc/collaborations/collaborations_bloc.dart';
import 'features/loading_feature/presentation/cubit/show_intro/show_intro_cubit.dart';
import 'features/loading_feature/presentation/page/loading_page.dart';
import 'features/main_feature/presentation/bloc/player/player_bloc.dart';
import 'features/main_feature/presentation/cubit/main_page_index/main_page_index_cubit.dart';
import 'features/main_feature/presentation/page/main_page.dart';

void main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AlbumsBloc>()),
        BlocProvider(create: (context) => sl<BeatsForPlacementBloc>()),
        BlocProvider(create: (context) => sl<CollaborationsBloc>()),
        BlocProvider(create: (context) => sl<ShowIntroCubit>()),
        BlocProvider(create: (context) => sl<MainPageIndexCubit>()),
        BlocProvider(create: (context) => sl<PlayerBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.red,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: GoogleFonts.ubuntu().fontFamily,
          textTheme: ThemeData.light().textTheme.apply(
                fontFamily: GoogleFonts.ubuntu().fontFamily,
                bodyColor: Colors.white,
              ),
        ),
        home: const LoadingPage(),
        routes: {
          '/loading': (context) => const LoadingPage(),
          '/home': (context) => const MainPage(),
          '/intro': (context) => const IntroPage(),
        },
      ),
    );
  }
}
