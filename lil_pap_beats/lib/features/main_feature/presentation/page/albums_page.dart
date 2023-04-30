import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lil_pap_beats/features/loading_feature/presentation/bloc/albums/albums_bloc.dart';

import '../../../../constant/colors.dart';
import '../../../album_feature/presentation/components/album_list_widget.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
              child: Text(
                "Albums Page",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<AlbumsBloc, AlbumsState>(
              builder: (context, state) {
                if (state is AlbumsLoaded) {
                  var albums = state.albums;
                  return ListView.builder(
                    itemCount: albums.length,
                    padding: const EdgeInsets.only(bottom: 120),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var album = albums[index];
                      return AlbumListWidget(
                        album: album,
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
