import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../loading_feature/presentation/bloc/albums/albums_bloc.dart';
import '../../../loading_feature/presentation/bloc/beats_for_placement/beats_for_placement_bloc.dart';
import '../../../loading_feature/presentation/bloc/collaborations/collaborations_bloc.dart';
import '../components/albums_main_page_widget.dart';
import '../components/beats_for_placement_main_page_widget.dart';
import '../components/collaboration_page_widget.dart';
import '../components/dopest_beats_main_page_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          BlocBuilder<BeatsForPlacementBloc, BeatsForPlacementState>(
            builder: (context, state) {
              if (state is BeatsForPlacementLoaded) {
                var beats = state.beats;
                return DopestBeatsMainPageWidget(beats: beats);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          const SizedBox(height: 5),
          BlocBuilder<AlbumsBloc, AlbumsState>(
            builder: (context, state) {
              if (state is AlbumsLoaded) {
                var albums = state.albums;
                return AlbumsMainPageWidget(albums: albums);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          const SizedBox(height: 15),
          BlocBuilder<CollaborationsBloc, CollaborationsState>(
            builder: (context, state) {
              if (state is CollaborationsLoaded) {
                var collaborations = state.collaborations;
                return CollaborationPageWidget(collaborations: collaborations);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          const SizedBox(height: 15),
          BlocBuilder<BeatsForPlacementBloc, BeatsForPlacementState>(
            builder: (context, state) {
              if (state is BeatsForPlacementLoaded) {
                var beats = state.beats;
                return BeatsForPlacementMainPageWidget(beats: beats);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          const SizedBox(height: 35),
          Text(
            "© Feel the rhythm, don't take it.",
            style: TextStyle(
              color: Colors.grey.withOpacity(0.4),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 130),
        ],
      ),
    );
  }
}
