import 'package:flutter/material.dart';
import 'package:lil_pap_beats/components/custom_cache_image.dart';
import 'package:lil_pap_beats/constant/values.dart';

import '../../../../constant/colors.dart';
import '../../../loading_feature/domain/entities/song.dart';

class BeatForPlacementWidget extends StatelessWidget {
  final Song beat;

  const BeatForPlacementWidget({
    super.key,
    required this.beat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kElementColor,
      ),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            margin: const EdgeInsets.all(7.5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CustomCachedImage(
                url: "$baseUrl/beats_for_placement/cover/${beat.toJson()}",
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              beat.title,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
