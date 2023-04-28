import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../constant/colors.dart';
import '../../../loading_feature/domain/entities/collaboration.dart';
import 'collaboration_widget.dart';

class CollaborationPageWidget extends StatelessWidget {
  const CollaborationPageWidget({
    super.key,
    required this.collaborations,
  });

  final List<Collaboration> collaborations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              const Text(
                'Collaborations',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
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
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: min(collaborations.length ~/ 2, 3),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CollaborationWidget(
                    collaboration: collaborations[index * 2],
                  ),
                  const SizedBox(height: 10),
                  CollaborationWidget(
                    collaboration: collaborations[index * 2 + 1],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
