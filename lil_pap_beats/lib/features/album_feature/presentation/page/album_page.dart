import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lil_pap_beats/constant/colors.dart';

import '../../../../components/custom_cache_image.dart';
import '../../../../constant/values.dart';
import '../../../loading_feature/domain/entities/album.dart';

class AlbumPage extends StatelessWidget {
  final Album album;

  const AlbumPage({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 360,
                backgroundColor: kElementColor,
                foregroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                elevation: 0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    album.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.6],
                        colors: [
                          album.dominantColor.withOpacity(0.8),
                          kBackgroundColor,
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 70,
                          right: 0,
                          left: 0,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomCachedImage(
                                radius: 15,
                                url: "$baseUrl/albums/cover/${album.title}",
                                height: 250,
                                width: 250,
                              ),
                              BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: CustomCachedImage(
                                  radius: 20,
                                  url: "$baseUrl/albums/cover/${album.title}",
                                  height: 250,
                                  width: 250,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - kToolbarHeight,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: album.songs.length,
                    itemBuilder: (context, index) {
                      final song = album.songs[index];
                      return ListTile(
                        selectedColor: kPrimaryColor,
                        leading: Text(
                          (index + 1).toString().padLeft(2, '0'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        title: Text(song.title),
                        onTap: () {},
                        subtitle: const Text(
                          "Lil Pap",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: kPrimaryColor,
              child: const Icon(
                Icons.play_arrow_rounded,
                color: kBackgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
