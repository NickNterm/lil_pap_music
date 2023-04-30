import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lil_pap_beats/components/custom_cache_image.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/values.dart';
import '../../../../dependency_injection.dart';
import '../../../album_feature/presentation/page/album_page.dart';
import '../../../loading_feature/domain/entities/album.dart';
import '../cubit/main_page_index/main_page_index_cubit.dart';

class AlbumsMainPageWidget extends StatelessWidget {
  const AlbumsMainPageWidget({
    super.key,
    required this.albums,
  });

  final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              const Text(
                'Don Albums',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  sl<MainPageIndexCubit>().changeIndex(1);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kElementColor,
                  ),
                  child: const Text(
                    'See all',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 185,
          child: ListView.builder(
            itemCount: min(5, albums.length),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlbumPage(
                        album: albums[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kElementColor,
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CustomCachedImage(
                          url: "$baseUrl/albums/cover/${albums[index].title}",
                          width: 130,
                          height: 130,
                        ),
                      ),
                      const SizedBox(height: 7.5),
                      Text(
                        albums[index].title,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
