import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lil_pap_beats/features/loading_feature/presentation/bloc/collaborations/collaborations_bloc.dart';

import '../components/collaboration_widget.dart';

class CollabsPage extends StatelessWidget {
  const CollabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Collabs Page",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BlocBuilder<CollaborationsBloc, CollaborationsState>(
              builder: (context, state) {
                if (state is CollaborationsLoaded) {
                  var collaborations = state.collaborations;
                  return ListView.builder(
                    itemCount: collaborations.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: CollaborationWidget(
                          collaboration: collaborations[index],
                        ),
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
