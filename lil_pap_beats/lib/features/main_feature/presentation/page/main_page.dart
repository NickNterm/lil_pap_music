import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:lil_pap_beats/constant/colors.dart';
import 'package:lil_pap_beats/features/main_feature/presentation/page/albums_page.dart';

import '../../../../dependency_injection.dart';
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

class _MainPageState extends State<MainPage> {
  List<Widget> pages = [
    const HomePage(),
    const AlbumsPage(),
    const BeatsForPlacementPage(),
    const CollabsPage(),
  ];
  PageController controller = PageController();
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
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(1),
                      Colors.black.withOpacity(0.7),
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
          ],
        ),
      ),
    );
  }
}
