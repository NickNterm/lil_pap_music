import 'package:flutter/material.dart';

import '../../../../components/custom_cache_image.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/values.dart';
import '../../../loading_feature/domain/entities/album.dart';
import '../page/album_page.dart';

class AlbumListWidget extends StatelessWidget {
  final Album album;

  const AlbumListWidget({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumPage(album: album),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kElementColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7.5),
                child: CustomCachedImage(
                  url: "$baseUrl/albums/cover/${album.title}",
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 3,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    album.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${album.songs.length} ${album.songs.length == 1 ? "Banger" : "Bangers"}",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
