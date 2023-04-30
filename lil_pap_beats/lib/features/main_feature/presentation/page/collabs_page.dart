import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lil_pap_beats/features/loading_feature/presentation/bloc/collaborations/collaborations_bloc.dart';

import '../../../../constant/colors.dart';
import '../components/collaboration_widget.dart';

class CollabsPage extends StatelessWidget {
  const CollabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
              child: Text(
                "Collabs Page",
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
            const SizedBox(height: 15),
            BlocBuilder<CollaborationsBloc, CollaborationsState>(
              builder: (context, state) {
                if (state is CollaborationsLoaded) {
                  var collaborations = state.collaborations;
                  return ListView.builder(
                    itemCount: collaborations.length,
                    padding: const EdgeInsets.only(bottom: 120),
                    physics: const NeverScrollableScrollPhysics(),
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
