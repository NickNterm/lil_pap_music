import 'dart:io';
import 'dart:math';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:lil_pap_beats/constant/colors.dart';
import 'package:lil_pap_beats/features/main_feature/presentation/page/albums_page.dart';

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
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            pages[currentIndex],
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
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            FeatherIcons.home,
                            color: currentIndex == 0
                                ? kPrimaryColor
                                : Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              currentIndex = 0;
                            });
                          },
                        ),
                        Visibility(
                          visible: currentIndex == 0,
                          child: const Text(
                            "Home",
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            FeatherIcons.disc,
                            color: currentIndex == 1
                                ? kPrimaryColor
                                : Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              currentIndex = 1;
                            });
                          },
                        ),
                        Visibility(
                          visible: currentIndex == 1,
                          child: const Text(
                            "Albums",
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            FeatherIcons.headphones,
                            color: currentIndex == 2
                                ? kPrimaryColor
                                : Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              currentIndex = 2;
                            });
                          },
                        ),
                        Visibility(
                          visible: currentIndex == 2,
                          child: const Text(
                            "BFP",
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            FeatherIcons.user,
                            color: currentIndex == 3
                                ? kPrimaryColor
                                : Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              currentIndex = 3;
                            });
                          },
                        ),
                        Visibility(
                          visible: currentIndex == 3,
                          child: const Text(
                            "Collabs",
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
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
