import 'package:flutter/material.dart';

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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey,
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
