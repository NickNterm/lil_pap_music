import 'package:flutter/material.dart';

import '../../../../components/custom_cache_image.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/values.dart';
import '../../../loading_feature/domain/entities/song.dart';

class DopeBeatWidget extends StatelessWidget {
  const DopeBeatWidget({
    super.key,
    required this.beat,
  });

  final Song beat;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 60,
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: kElementColor,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                child: CustomCachedImage(
                  url: "$baseUrl/beats_for_placement/cover/${beat.toJson()}",
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text(
                beat.title,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
