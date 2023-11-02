import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lil_pap_beats/constant/colors.dart';
import 'package:lil_pap_beats/features/main_feature/presentation/page/albums_page.dart';

import '../../../../components/custom_cache_image.dart';
import '../../../../dependency_injection.dart';
import '../bloc/player/player_bloc.dart';
import '../components/navigation_button_widget.dart';
import '../cubit/main_page_index/main_page_index_cubit.dart';
import 'beats_for_placement_page.dart';
import 'collabs_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List<Widget> pages = [
    const HomePage(),
    const AlbumsPage(),
    const BeatsForPlacementPage(),
    const CollabsPage(),
  ];
  PageController controller = PageController();
  late AnimationController _animationController;
  @override
  initState() {
    super.initState();
    controller = PageController(initialPage: sl<MainPageIndexCubit>().state);
    sl<MainPageIndexCubit>().stream.listen((index) {
      controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: pages,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(1),
                      Colors.black.withOpacity(0.0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    NavigationButton(
                      icon: FeatherIcons.home,
                      label: "Home",
                      index: 0,
                    ),
                    NavigationButton(
                      icon: FeatherIcons.disc,
                      label: "Home",
                      index: 1,
                    ),
                    NavigationButton(
                      icon: FeatherIcons.headphones,
                      label: "BFP",
                      index: 2,
                    ),
                    NavigationButton(
                      icon: FeatherIcons.user,
                      label: "Collabs",
                      index: 3,
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<PlayerBloc, PlayerState>(
              builder: (context, state) {
                if (state is PlayerLoaded && state.player.song.title != "") {
                  return Positioned(
                    bottom: 75,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        color: kElementColor,
                      ),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withOpacity(0.1),
                                ),
                                child: CustomCachedImage(
                                  url: getSongCoverUrl(
                                    state.player.songCategory,
                                    state.player.song,
                                    state.player.album,
                                  ),
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.player.song.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "Lil Pap",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                onPressed: () {
                                  if (state.player.audioPlayer.playing ==
                                      true) {
                                    state.player.audioPlayer.pause();
                                    _animationController.forward();
                                  } else {
                                    state.player.audioPlayer.play();
                                    _animationController.reverse();
                                  }
                                },
                                icon: AnimatedIcon(
                                  color: Colors.white,
                                  icon: AnimatedIcons.pause_play,
                                  progress: _animationController,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
